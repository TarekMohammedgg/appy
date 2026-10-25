import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';

enum CheckTone { accent, success }

/// 22px checklist / habit circle with a 44px tap target.
class CheckCircle extends StatelessWidget {
  const CheckCircle({
    super.key,
    required this.checked,
    required this.onTap,
    required this.semanticLabel,
    this.tone = CheckTone.accent,
  });

  final bool checked;
  final VoidCallback onTap;
  final String semanticLabel;
  final CheckTone tone;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final fill = tone == CheckTone.accent ? c.accent : c.success;
    return Semantics(
      checked: checked,
      label: semanticLabel,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: SizedBox(
          width: 44,
          height: 44,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: checked ? fill : null,
                border: Border.all(color: checked ? fill : c.grey3, width: 1.5),
              ),
              child: checked
                  ? const Icon(CupertinoIcons.checkmark,
                      size: 13, color: Color(0xFFFFFFFF))
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
