import 'package:flutter/widgets.dart';

/// Near-opaque bar surface (pill, editor toolbar).
// ponytail: no BackdropFilter. A live blur re-renders on every scroll frame
// and the 95% tint hides it anyway; bring it back only if a design needs
// see-through bars.
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
    final content = ColoredBox(color: color, child: child);
    return borderRadius == null
        ? content
        : ClipRRect(borderRadius: borderRadius!, child: content);
  }
}
