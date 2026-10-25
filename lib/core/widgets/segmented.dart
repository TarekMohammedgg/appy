import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';

/// iOS segmented control with the app's colors. In dark mode the thumb must be
/// lighter than the track, otherwise the selection disappears.
class AppSegmented<T extends Object> extends StatelessWidget {
  const AppSegmented({
    super.key,
    required this.value,
    required this.segments,
    required this.onChanged,
  });

  final T value;
  final List<(T, String)> segments;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return CupertinoSlidingSegmentedControl<T>(
      groupValue: value,
      thumbColor: dark ? const Color(0xFF636366) : c.surface,
      backgroundColor: c.fill3,
      onValueChanged: (v) => onChanged(v as T),
      children: {
        for (final (v, label) in segments)
          v: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(label, style: AppText.footnoteStrong.copyWith(color: c.ink)),
          ),
      },
    );
  }
}
