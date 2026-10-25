import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text.dart';

/// Attach + web toggle on the start side, field, mic that turns into send.
class ChatComposer extends StatefulWidget {
  const ChatComposer({
    super.key,
    required this.webSearch,
    required this.onToggleWeb,
    required this.onSend,
    required this.bottomPadding,
  });

  final bool webSearch;
  final VoidCallback onToggleWeb;
  final ValueChanged<String> onSend;
  final double bottomPadding;

  @override
  State<ChatComposer> createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer> {
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

  void _send() {
    widget.onSend(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final hasText = _controller.text.trim().isNotEmpty;
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, widget.bottomPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 4,
        children: [
          IconButton(
            tooltip: 'إرفاق',
            onPressed: () {},
            icon: Icon(CupertinoIcons.paperclip, color: c.ink2, size: 22),
          ),
          _WebToggle(active: widget.webSearch, onTap: widget.onToggleWeb),
          Expanded(
            child: TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 6,
              textInputAction: TextInputAction.newline,
              style: AppText.body.copyWith(color: c.ink),
              decoration: InputDecoration(
                hintText: 'اسأل أو سجّل حاجة…',
                hintStyle: AppText.body.copyWith(color: c.ink3),
                filled: true,
                fillColor: c.raised,
                isDense: true,
                contentPadding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          hasText
              ? IconButton(
                  tooltip: 'إرسال',
                  onPressed: _send,
                  icon: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(color: c.accent, shape: BoxShape.circle),
                    child: Icon(CupertinoIcons.arrow_up, size: 18, color: c.onAccent),
                  ),
                )
              : IconButton(
                  tooltip: 'تسجيل صوت',
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.mic, color: c.ink2, size: 22),
                ),
        ],
      ),
    );
  }
}

class _WebToggle extends StatelessWidget {
  const _WebToggle({required this.active, required this.onTap});

  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final color = active ? c.accentStrong : c.grey;
    return Semantics(
      button: true,
      toggled: active,
      label: 'البحث على النت',
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 48,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 36,
              padding: EdgeInsetsDirectional.symmetric(horizontal: active ? 10 : 7),
              decoration: BoxDecoration(
                color: active ? c.accentSoft : c.fill3,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  Icon(CupertinoIcons.globe, size: 22, color: color),
                  if (active)
                    Text('Web',
                        style: AppText.footnoteStrong.copyWith(color: color)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
