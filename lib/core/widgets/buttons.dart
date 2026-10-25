import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../layout.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import 'pressable.dart';

/// The app-bar menu icon shared by every tab; opens Settings.
class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'الإعدادات',
      onPressed: () => context.push('/settings'),
      icon: Icon(CupertinoIcons.line_horizontal_3,
          color: context.colors.accentStrong, size: 24),
    );
  }
}

/// Gold circular action above the tab pill, on the end side. Use inside a Stack.
class AppFab extends StatelessWidget {
  const AppFab({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return PositionedDirectional(
      end: 20,
      bottom: navClearance(context),
      child: Pressable(
        onTap: onPressed,
        semanticLabel: label,
        borderRadius: BorderRadius.circular(kFabSize / 2),
        child: Container(
          width: kFabSize,
          height: kFabSize,
          decoration: BoxDecoration(
            color: c.accent,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0x14000000), width: 0.5),
          ),
          child: Icon(icon, color: c.onAccent, size: 22),
        ),
      ),
    );
  }
}

/// Gold-soft pill button ("ابحث على النت").
class TintedButton extends StatelessWidget {
  const TintedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Pressable(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: c.accentSoft,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 17, color: c.accentStrong),
              const SizedBox(width: 6),
            ],
            Text(label, style: AppText.subhead.copyWith(color: c.accentStrong)),
          ],
        ),
      ),
    );
  }
}

/// Text-only gold button ("تعديل", "تراجع", "تم").
class PlainButton extends StatelessWidget {
  const PlainButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.bold = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    // Style the Text, not the button: a button textStyle drops the Arabic fallback font.
    final color = context.colors.accentStrong;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color,
        overlayColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        minimumSize: const Size(0, 44),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(label,
          style: (bold ? AppText.headline : AppText.bodyCompact).copyWith(color: color)),
    );
  }
}

/// Full-width gold primary button.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Opacity(
      opacity: onPressed == null ? 0.4 : 1,
      child: Pressable(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: c.accent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(label, style: AppText.headline.copyWith(color: c.onAccent)),
        ),
      ),
    );
  }
}
