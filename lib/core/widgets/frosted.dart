import 'dart:ui';

import 'package:flutter/widgets.dart';

/// Frosted bar: tint over a 20px blur (nav bars, pill, editor toolbar).
class Frosted extends StatelessWidget {
  const Frosted({
    super.key,
    required this.color,
    required this.child,
    this.borderRadius,
  });

  final Color color;
  final Widget child;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final content = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: ColoredBox(color: color, child: child),
    );
    return borderRadius == null
        ? ClipRect(child: content)
        : ClipRRect(borderRadius: borderRadius!, child: content);
  }
}
