import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/widgets/pressable.dart';

// ── AI assist ("AI sidebar") ──────────────────────────────────────────────

void showAiAssistSheet(BuildContext context, String noteTitle) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.4,
      minChildSize: 0.25,
      maxChildSize: 0.9,
      snap: true,
      snapSizes: const [0.4, 0.9],
      builder: (context, scroll) => _AiAssistBody(scroll: scroll, noteTitle: noteTitle),
    ),
  );
}

class _AiAssistBody extends StatefulWidget {
  const _AiAssistBody({required this.scroll, required this.noteTitle});

  final ScrollController scroll;
  final String noteTitle;

  @override
  State<_AiAssistBody> createState() => _AiAssistBodyState();
}

class _AiAssistBodyState extends State<_AiAssistBody> {
  String? _asked;

  static const _suggestions = ['لخّص الملاحظة', 'إيه المهام اللي فيها؟', 'اقترح عنوان'];

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final title = widget.noteTitle.isEmpty ? 'ملاحظة جديدة' : widget.noteTitle;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
            child: Row(
              spacing: 8,
              children: [
                Icon(CupertinoIcons.sparkles, size: 20, color: c.accentStrong),
                Text('اسأل عن الملاحظة', style: AppText.headline.copyWith(color: c.ink)),
                const Spacer(),
                Container(
                  constraints: const BoxConstraints(maxWidth: 160),
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: c.fill3,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text('عن: $title',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.footnote.copyWith(color: c.ink2)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              controller: widget.scroll,
              padding: const EdgeInsets.all(16),
              children: [
                if (_asked == null)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final s in _suggestions)
                        Pressable(
                          onTap: () => setState(() => _asked = s),
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
                  )
                else ...[
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: c.raised,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(_asked!, style: AppText.body.copyWith(color: c.ink)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'الملاحظة بتقول إن أول phase هتبقى capture + sync لـNotion، '
                    'وإن اختيار الـeditor مستني الـspike. فيها 3 مهام، واحدة منهم خلصت.',
                    style: AppText.body.copyWith(color: c.ink),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 8, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: AppText.body.copyWith(color: c.ink),
                    decoration: InputDecoration(
                      hintText: 'اسأل عن الملاحظة دي…',
                      hintStyle: AppText.body.copyWith(color: c.ink3),
                      filled: true,
                      fillColor: c.raised,
                      isDense: true,
                      contentPadding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 14, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'تسجيل صوت',
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.mic, color: c.ink2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Recording ─────────────────────────────────────────────────────────────

void showRecordingSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isDismissible: false,
    enableDrag: false,
    builder: (_) => const _RecordingSheet(),
  );
}

class _RecordingSheet extends StatefulWidget {
  const _RecordingSheet();

  @override
  State<_RecordingSheet> createState() => _RecordingSheetState();
}

class _RecordingSheetState extends State<_RecordingSheet> {
  final _watch = Stopwatch()..start();
  late final Timer _ticker;

  @override
  void initState() {
    super.initState();
    HapticFeedback.mediumImpact();
    _ticker = Timer.periodic(const Duration(milliseconds: 150), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  void _stop() {
    HapticFeedback.mediumImpact();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final e = _watch.elapsed;
    final t = e.inMilliseconds / 150;
    final time = '${e.inMinutes}:${(e.inSeconds % 60).toString().padLeft(2, '0')}';
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text('بيسجّل…', style: AppText.footnote.copyWith(color: c.ink2)),
            Text(time,
                style: AppText.title1.copyWith(
                    color: c.ink, fontFeatures: const [FontFeature.tabularFigures()])),
            SizedBox(
              height: 40,
              child: ExcludeSemantics(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 3,
                  children: [
                    for (var i = 0; i < 32; i++)
                      Container(
                        width: 3,
                        height: 6 + 30 * (0.5 + 0.5 * math.sin(t * 0.8 + i * 0.6)).abs(),
                        decoration: BoxDecoration(
                          color: c.danger,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Semantics(
              button: true,
              label: 'وقّف التسجيل',
              excludeSemantics: true,
              child: GestureDetector(
                onTap: _stop,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(color: c.danger, shape: BoxShape.circle),
                  child: Center(
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text('هيتحوّل لنص ويتحفظ في الملاحظة',
                style: AppText.footnote.copyWith(color: c.ink2)),
          ],
        ),
      ),
    );
  }
}

// ── Format (Aa) ───────────────────────────────────────────────────────────

void showFormatSheet(BuildContext context) {
  showModalBottomSheet<void>(context: context, builder: (_) => const _FormatSheet());
}

class _FormatSheet extends StatefulWidget {
  const _FormatSheet();

  @override
  State<_FormatSheet> createState() => _FormatSheetState();
}

class _FormatSheetState extends State<_FormatSheet> {
  int _style = 3;
  final _inline = <int>{};

  static const _styles = [
    ('عنوان', AppText.title3),
    ('عنوان رئيسي', AppText.headline),
    ('عنوان فرعي', AppText.subhead),
    ('نص', AppText.bodyCompact),
    ('Mono', AppText.mono),
  ];

  static const _inlineItems = [
    ('B', 'عريض'),
    ('I', 'مائل'),
    ('U', 'تحته خط'),
    ('S', 'عليه خط'),
  ];

  static const _lists = [
    (CupertinoIcons.list_bullet, 'نقط'),
    (CupertinoIcons.list_dash, 'شرط'),
    (CupertinoIcons.list_number, 'أرقام'),
    (CupertinoIcons.text_quote, 'اقتباس'),
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            Text('تنسيق',
                textAlign: TextAlign.center,
                style: AppText.headline.copyWith(color: c.ink)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 8,
                children: [
                  for (var i = 0; i < _styles.length; i++)
                    Pressable(
                      onTap: () => setState(() => _style = i),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 44,
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 14),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: i == _style ? c.accentSoft : c.raised,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(_styles[i].$1,
                            style: _styles[i].$2.copyWith(
                                color: i == _style ? c.accentStrong : c.ink)),
                      ),
                    ),
                ],
              ),
            ),
            Row(
              spacing: 8,
              children: [
                for (var i = 0; i < _inlineItems.length; i++)
                  Expanded(
                    child: Semantics(
                      button: true,
                      toggled: _inline.contains(i),
                      label: _inlineItems[i].$2,
                      excludeSemantics: true,
                      child: Pressable(
                        onTap: () => setState(
                            () => _inline.contains(i) ? _inline.remove(i) : _inline.add(i)),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _inline.contains(i) ? c.accentSoft : c.raised,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _inlineItems[i].$1,
                            style: AppText.headline.copyWith(
                              color: _inline.contains(i) ? c.accentStrong : c.ink,
                              fontWeight: i == 0 ? FontWeight.w700 : FontWeight.w400,
                              fontStyle: i == 1 ? FontStyle.italic : null,
                              decoration: switch (i) {
                                2 => TextDecoration.underline,
                                3 => TextDecoration.lineThrough,
                                _ => null,
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                for (final (icon, label) in _lists)
                  Expanded(
                    child: Pressable(
                      onTap: () {},
                      semanticLabel: label,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: c.raised,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(icon, size: 22, color: c.ink),
                      ),
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
