import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/pressable.dart';
import '../../data/models/chat_message.dart';
import '../view_model/chat_cubit.dart';
import '../view_model/chat_state.dart';
import '../widgets/chat_composer.dart';
import '../widgets/message_views.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    // Read here, above this Scaffold, which strips the keyboard inset.
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    final cubit = context.read<ChatCubit>();

    return Scaffold(
      backgroundColor: c.canvas,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) => Column(
            children: [
              SizedBox(
                height: 44,
                child: Row(
                  children: [
                    const SettingsButton(),
                    Expanded(
                      child: Text('appy',
                          textAlign: TextAlign.center,
                          style: AppText.headline.copyWith(color: c.ink)),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: state.messages.isEmpty && !state.thinking
                    ? _EmptyState(
                        suggestions: cubit.suggestions, onPick: cubit.send)
                    : _MessageList(state: state, cubit: cubit),
              ),
              ChatComposer(
                webSearch: state.webSearch,
                onToggleWeb: cubit.toggleWebSearch,
                onSend: cubit.send,
                bottomPadding: keyboardOpen ? 8 : pillBottom(context) + kPillHeight + 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({required this.state, required this.cubit});

  final ChatState state;
  final ChatCubit cubit;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      for (final m in state.messages)
        switch (m) {
          UserMessage() => UserBubble(m),
          AnswerMessage() => AnswerView(m),
          CaptureMessage() => CaptureCard(m, onUndo: () => cubit.undo(m.id)),
          NoAnswerMessage() => NoAnswerView(
              onSearchWeb: () {
                if (!state.webSearch) cubit.toggleWebSearch();
              },
            ),
        },
      if (state.thinking)
        const Align(alignment: AlignmentDirectional.centerStart, child: TypingDots()),
    ];
    // Reversed so the list sticks to the newest message at the bottom.
    return ListView.separated(
      reverse: true,
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (_, i) => items[items.length - 1 - i],
    );
  }
}

/// Blank chat: one greeting and a few suggestions. No numbers until asked.
class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.suggestions, required this.onPick});

  final List<String> suggestions;
  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Align(
      alignment: const Alignment(0, -0.25),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 20,
          children: [
            Text('أهلاً يا طارق، عايز تعرف إيه؟',
                textAlign: TextAlign.center,
                style: AppText.title2.copyWith(color: c.ink)),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final s in suggestions)
                  Pressable(
                    onTap: () => onPick(s),
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: c.fill3,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(s, style: AppText.subhead.copyWith(color: c.ink)),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
