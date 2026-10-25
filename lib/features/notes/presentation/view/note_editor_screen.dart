import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/check_circle.dart';
import '../../../../core/widgets/frosted.dart';
import '../../../../core/widgets/label_chip.dart';
import '../../../../core/widgets/pressable.dart';
import '../../data/models/note.dart';
import '../view_model/note_editor_cubit.dart';
import '../widgets/audio_attachment.dart';
import '../widgets/editor_sheets.dart';

/// Apple Notes-style page. Title/body are plain fields until the rich-text
/// editor package is picked (spike); the blocks below show the final look.
class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late final NoteDetail _initial = context.read<NoteEditorCubit>().state;
  late final _title = TextEditingController(text: _initial.title);
  late final _body = TextEditingController(text: _initial.body);

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final cubit = context.read<NoteEditorCubit>();
    return Scaffold(
      backgroundColor: c.canvas,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 44,
              child: Row(
                children: [
                  Pressable(
                    onTap: () => context.pop(),
                    semanticLabel: 'رجوع للملاحظات',
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 8, end: 8),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.back, color: c.accentStrong, size: 26),
                          Text('الملاحظات',
                              style: AppText.bodyCompact.copyWith(color: c.accentStrong)),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  PlainButton(
                    label: 'تم',
                    bold: true,
                    onPressed: () => FocusScope.of(context).unfocus(),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<NoteEditorCubit, NoteDetail>(
                builder: (context, note) => ListView(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 24),
                  children: [
                    _DateStamp(note.dateLabel),
                    TextField(
                      controller: _title,
                      maxLines: null,
                      style: AppText.title1.copyWith(color: c.ink),
                      decoration: InputDecoration.collapsed(
                        hintText: 'العنوان',
                        hintStyle: AppText.title1.copyWith(color: c.ink3),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _body,
                      maxLines: null,
                      autofocus: note.id == 'new',
                      style: AppText.body.copyWith(color: c.ink),
                      decoration: InputDecoration.collapsed(
                        hintText: 'ابدأ الكتابة…',
                        hintStyle: AppText.body.copyWith(color: c.ink3),
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (var i = 0; i < note.checklist.length; i++)
                      Row(
                        children: [
                          // Pull the 44px tap box in so the circle lines up with text.
                          Transform.translate(
                            offset: Offset(
                                Directionality.of(context) == TextDirection.rtl ? 11 : -11,
                                0),
                            child: CheckCircle(
                              checked: note.checklist[i].done,
                              semanticLabel: note.checklist[i].text,
                              onTap: () => cubit.toggleItem(i),
                            ),
                          ),
                          Expanded(
                            child: Text(note.checklist[i].text,
                                style: AppText.body.copyWith(
                                    color: note.checklist[i].done ? c.ink2 : c.ink)),
                          ),
                        ],
                      ),
                    if (note.audio != null) ...[
                      const SizedBox(height: 12),
                      AudioAttachment(note.audio!),
                    ],
                    if (note.labels.isNotEmpty || note.suggestedLabels.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final l in note.labels) LabelChip(l),
                          for (final l in note.suggestedLabels)
                            SuggestedLabelChip(
                              l,
                              onAccept: () => cubit.acceptLabel(l),
                              onReject: () => cubit.rejectLabel(l),
                            ),
                        ],
                      ),
                    ],
                    if (note.related.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Text('مرتبطة',
                          style: AppText.footnoteStrong.copyWith(color: c.ink2)),
                      for (final r in note.related)
                        Pressable(
                          onTap: () => context.push('/note/${r.id}'),
                          child: SizedBox(
                            height: 44,
                            child: Row(
                              spacing: 8,
                              children: [
                                Icon(CupertinoIcons.link, size: 17, color: c.accentStrong),
                                Text(r.title,
                                    style:
                                        AppText.subhead.copyWith(color: c.accentStrong)),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ),
            _EditorToolbar(
              onFormat: () => showFormatSheet(context),
              onChecklist: cubit.addItem,
              onRecord: () => showRecordingSheet(context),
              onAi: () => showAiAssistSheet(context, _title.text),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateStamp extends StatelessWidget {
  const _DateStamp(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 6,
        children: [
          Text(label, style: AppText.footnote.copyWith(color: c.ink2)),
          // Grey cloud = waiting to sync to Notion; hidden once synced.
          Semantics(
            label: 'لسه ما اتزامنتش مع Notion',
            child: Icon(CupertinoIcons.cloud, size: 14, color: c.grey),
          ),
        ],
      ),
    );
  }
}

class _EditorToolbar extends StatelessWidget {
  const _EditorToolbar({
    required this.onFormat,
    required this.onChecklist,
    required this.onRecord,
    required this.onAi,
  });

  final VoidCallback onFormat;
  final VoidCallback onChecklist;
  final VoidCallback onRecord;
  final VoidCallback onAi;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    Widget item(IconData icon, String tip, VoidCallback onTap, {Color? color}) =>
        IconButton(
          tooltip: tip,
          onPressed: onTap,
          icon: Icon(icon, size: 22, color: color ?? c.ink),
        );
    return Frosted(
      color: c.parchment.withValues(alpha: 0.9),
      child: SizedBox(
        height: 44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            item(CupertinoIcons.textformat, 'تنسيق', onFormat),
            item(CupertinoIcons.checkmark_circle, 'قايمة مهام', onChecklist),
            item(CupertinoIcons.camera, 'صورة', () {}),
            item(CupertinoIcons.mic, 'تسجيل صوت', onRecord),
            item(CupertinoIcons.sparkles, 'اسأل عن الملاحظة', onAi,
                color: c.accentStrong),
          ],
        ),
      ),
    );
  }
}
