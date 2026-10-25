import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/inset_group.dart';
import '../../../../core/widgets/large_title_bar.dart';
import '../../../../core/widgets/pressable.dart';
import '../../data/models/note.dart';
import '../view_model/notes_cubit.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  static const _groupTitles = {
    NoteGroup.pinned: 'مثبّتة',
    NoteGroup.today: 'النهارده',
    NoteGroup.week: 'آخر 7 أيام',
  };

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.grouped,
      body: Stack(
        children: [
          BlocBuilder<NotesCubit, NotesState>(
            builder: (context, state) {
              final visible = state.visible;
              return CustomScrollView(
                slivers: [
                  largeTitleBar(context, 'الملاحظات'),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                      child: CupertinoSearchTextField(
                        placeholder: 'بحث',
                        onChanged: context.read<NotesCubit>().search,
                        style: AppText.bodyCompact.copyWith(color: c.ink),
                        backgroundColor: c.fill3,
                      ),
                    ),
                  ),
                  if (visible.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 48),
                        child: Text('مفيش ملاحظات فيها "${state.query}"',
                            textAlign: TextAlign.center,
                            style: AppText.body.copyWith(color: c.ink2)),
                      ),
                    ),
                  for (final group in NoteGroup.values)
                    if (visible.any((n) => n.group == group))
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionHeader(_groupTitles[group]!),
                            InsetGroup(children: [
                              for (final n in visible.where((n) => n.group == group))
                                _NoteRow(n),
                            ]),
                          ],
                        ),
                      ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: navClearance(context) + kFabSize + 16),
                  ),
                ],
              );
            },
          ),
          AppFab(
            icon: CupertinoIcons.square_pencil,
            label: 'ملاحظة جديدة',
            onPressed: () => context.push('/note/new'),
          ),
        ],
      ),
    );
  }
}

class _NoteRow extends StatelessWidget {
  const _NoteRow(this.note);

  final Note note;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Pressable(
      onTap: () => context.push('/note/${note.id}'),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.headline.copyWith(color: c.ink)),
            Row(
              spacing: 6,
              children: [
                Text(note.timeLabel, style: AppText.subhead.copyWith(color: c.ink)),
                Expanded(
                  child: Text(note.preview,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.subhead.copyWith(color: c.ink2)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
