import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import 'auto_direction.dart';
import 'pressable.dart';

/// The one way to type something new: add a task, start a note, ask the AI.
///
/// A centered dialog instead of a bottom sheet: the dialog rises with the
/// keyboard on its own, and its content scrolls, so a keyboard opening mid-
/// animation can't overflow it.
class InputDialog extends StatefulWidget {
  const InputDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.hint,
    required this.onSubmit,
    this.contextLabel,
    this.header,
    this.suggestions = const [],
    this.multiline = false,
    this.closeOnSubmit = true,
  });

  final IconData icon;
  final String title;
  final String hint;

  /// Called after the dialog closes (when [closeOnSubmit]), so it may navigate.
  final ValueChanged<String> onSubmit;

  /// Small grey chip next to the title ("عن: اجتماع مشروع appy").
  final String? contextLabel;

  /// Anything between the title and the field (segmented control, answer).
  final Widget? header;
  final List<String> suggestions;
  final bool multiline;
  final bool closeOnSubmit;

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit(String text) {
    final value = text.trim();
    if (value.isEmpty) return;
    if (widget.closeOnSubmit) {
      Navigator.pop(context);
    } else {
      _controller.clear();
    }
    widget.onSubmit(value);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final canSend = _controller.text.trim().isNotEmpty;
    return Dialog(
      backgroundColor: c.surface,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      // Hairline edge: in dark mode the dialog matches the cards behind it.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: c.separator, width: 0.5),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            Row(
              spacing: 10,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: c.accentSoft, shape: BoxShape.circle),
                  child: Icon(widget.icon, size: 18, color: c.accentStrong),
                ),
                Expanded(
                  child: Text(widget.title, style: AppText.headline.copyWith(color: c.ink)),
                ),
                if (widget.contextLabel != null)
                  Container(
                    constraints: const BoxConstraints(maxWidth: 140),
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: c.fill3,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(widget.contextLabel!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.footnote.copyWith(color: c.ink2)),
                  ),
              ],
            ),
            ?widget.header,
            if (widget.suggestions.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final s in widget.suggestions)
                    Pressable(
                      onTap: () => _submit(s),
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: c.fill3,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(s, style: AppText.subhead.copyWith(color: c.ink)),
                      ),
                    ),
                ],
              ),
            Container(
              padding: const EdgeInsetsDirectional.fromSTEB(14, 6, 6, 6),
              decoration: BoxDecoration(
                color: c.raised,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 8,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: AutoDirection(
                        controller: _controller,
                        child: TextField(
                          controller: _controller,
                          autofocus: true,
                          minLines: 1,
                          maxLines: widget.multiline ? 6 : 1,
                          textInputAction: widget.multiline
                              ? TextInputAction.newline
                              : TextInputAction.done,
                          onSubmitted: widget.multiline ? null : _submit,
                          style: AppText.bodyCompact.copyWith(color: c.ink),
                          decoration: InputDecoration.collapsed(
                            hintText: widget.hint,
                            hintStyle: AppText.bodyCompact.copyWith(color: c.ink3),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Semantics(
                    button: true,
                    label: 'إرسال',
                    child: GestureDetector(
                      onTap: canSend ? () => _submit(_controller.text) : null,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: canSend ? c.accent : c.fill3,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(CupertinoIcons.arrow_up,
                            size: 18, color: canSend ? c.onAccent : c.ink3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
