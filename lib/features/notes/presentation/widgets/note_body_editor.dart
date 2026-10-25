import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/widgets/auto_direction.dart';

/// Note body where every line picks its own direction: "السلام" sits right,
/// "hi" on the next line sits left. A plain TextField can't do this, it has
/// one direction for all its lines.
///
/// Fleather's [AutoTextDirection] sets a line's direction from the first
/// character typed into it. Lines are LTR unless marked RTL, so empty lines
/// start RTL (Arabic-first) and flip to LTR once English is typed.
class NoteBodyEditor extends StatefulWidget {
  const NoteBodyEditor({super.key, required this.initialText});

  final String initialText;

  @override
  State<NoteBodyEditor> createState() => _NoteBodyEditorState();
}

class _NoteBodyEditorState extends State<NoteBodyEditor> {
  late final _controller = noteBodyController(widget.initialText);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    // AppText has no font family; take Inter + Arabic fallback from the theme.
    final style = DefaultTextStyle.of(context).style.merge(AppText.body).copyWith(color: c.ink);
    final base = FleatherThemeData.fallback(context);
    return FleatherTheme(
      data: base.copyWith(
        paragraph: TextBlockTheme(style: style, spacing: const VerticalSpacing.zero()),
      ),
      child: Stack(
        children: [
          ListenableBuilder(
            listenable: _controller,
            builder: (context, _) => _controller.document.toPlainText().trim().isEmpty
                ? IgnorePointer(
                    child: Text('ابدأ الكتابة…', style: style.copyWith(color: c.ink3)),
                  )
                : const SizedBox.shrink(),
          ),
          FleatherEditor(controller: _controller, scrollable: false),
        ],
      ),
    );
  }
}

// ponytail: only auto direction for now; markdown/emoji shortcuts and the
// format sheet's bold/lists get wired here in the logic phase.
FleatherController noteBodyController(String text) => FleatherController(
      document: bodyDocument(text),
      autoFormats: AutoFormats(autoFormats: const [AutoTextDirection()]),
    );

/// Plain text → document, marking each RTL (or empty) line as RTL.
ParchmentDocument bodyDocument(String text) {
  final rtl = {
    ...ParchmentAttribute.rtl.toJson(),
    ...ParchmentAttribute.alignment.right.toJson(),
  };
  final delta = Delta();
  for (final line in text.split('\n')) {
    if (line.isNotEmpty) delta.insert(line);
    final dir = detectTextDirection(line) ?? TextDirection.rtl;
    delta.insert('\n', dir == TextDirection.rtl ? rtl : null);
  }
  return ParchmentDocument.fromDelta(delta);
}
