import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/pressable.dart';
import '../../data/models/chat_message.dart';

class UserBubble extends StatelessWidget {
  const UserBubble(this.message, {super.key});

  final UserMessage message;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.8),
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: c.raised,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(message.text, style: AppText.body.copyWith(color: c.ink)),
        ),
      ),
    );
  }
}

/// Plain-text answer (no bubble) with inline [n] citations and a sources list.
class AnswerView extends StatelessWidget {
  const AnswerView(this.message, {super.key});

  final AnswerMessage message;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(children: [
            for (final part in message.parts) ...[
              TextSpan(text: part.text),
              if (part.citation != null)
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: _CitationBadge(
                    index: part.citation!,
                    source: message.sources[part.citation! - 1],
                  ),
                ),
            ],
          ]),
          style: AppText.body.copyWith(color: c.ink),
        ),
        const SizedBox(height: 12),
        Text('المصادر', style: AppText.footnote.copyWith(color: c.ink2)),
        const SizedBox(height: 6),
        for (var i = 0; i < message.sources.length; i++)
          _SourceRow(index: i + 1, source: message.sources[i]),
      ],
    );
  }
}

class _CitationBadge extends StatelessWidget {
  const _CitationBadge({required this.index, required this.source});

  final int index;
  final Source source;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      button: true,
      label: 'مصدر $index: ${source.title}',
      excludeSemantics: true,
      child: GestureDetector(
        onTap: () => context.push('/note/${source.noteId}'),
        child: Container(
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 3),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            color: c.accentSoft,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text('$index',
              style: AppText.caption1
                  .copyWith(color: c.accentStrong, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}

class _SourceRow extends StatelessWidget {
  const _SourceRow({required this.index, required this.source});

  final int index;
  final Source source;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Pressable(
      onTap: () => context.push('/note/${source.noteId}'),
      child: Container(
        constraints: const BoxConstraints(minHeight: 36),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: c.separator, width: 0.5)),
        ),
        child: Row(
          spacing: 8,
          children: [
            Icon(CupertinoIcons.doc_text, size: 17, color: c.ink2),
            Expanded(
              child: Text('$index · ${source.title}',
                  style: AppText.footnote.copyWith(color: c.ink),
                  overflow: TextOverflow.ellipsis),
            ),
            Text(source.dateLabel, style: AppText.footnote.copyWith(color: c.ink2)),
          ],
        ),
      ),
    );
  }
}

class CaptureCard extends StatelessWidget {
  const CaptureCard(this.message, {super.key, required this.onUndo});

  final CaptureMessage message;
  final VoidCallback onUndo;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c.separator, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Row(
            spacing: 6,
            children: [
              Icon(CupertinoIcons.checkmark_circle, size: 17, color: c.success),
              Text(message.title,
                  style: AppText.footnoteStrong.copyWith(color: c.ink)),
            ],
          ),
          Text(message.body, style: AppText.subhead.copyWith(color: c.ink)),
          Row(
            children: [
              PlainButton(label: 'تعديل', onPressed: () {}),
              PlainButton(label: 'تراجع', onPressed: onUndo),
            ],
          ),
        ],
      ),
    );
  }
}

class NoAnswerView extends StatelessWidget {
  const NoAnswerView({super.key, required this.onSearchWeb});

  final VoidCallback onSearchWeb;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text('مش لاقي حاجة عن ده في ملاحظاتك.',
            style: AppText.body.copyWith(color: c.ink2)),
        TintedButton(
          label: 'ابحث على النت',
          icon: CupertinoIcons.globe,
          onPressed: onSearchWeb,
        ),
      ],
    );
  }
}

/// Three-dot grey pulse while the answer is being prepared.
class TypingDots extends StatefulWidget {
  const TypingDots({super.key});

  @override
  State<TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<TypingDots>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final grey = context.colors.grey;
    return Semantics(
      label: 'بيدوّر في ملاحظاتك',
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            for (var i = 0; i < 3; i++)
              Opacity(
                opacity: 0.3 + 0.7 * (1 - ((_controller.value * 3 - i) % 3).clamp(0, 1)),
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(color: grey, shape: BoxShape.circle),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
