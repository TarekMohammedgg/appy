import 'package:flutter/widgets.dart';

/// Direction of the first strong character: Arabic/Hebrew → RTL, Latin → LTR.
/// Null when there's none yet (empty, digits, emoji), so callers keep the app's.
TextDirection? detectTextDirection(String text) {
  for (final r in text.runes) {
    if ((r >= 0x0590 && r <= 0x08FF) ||
        (r >= 0xFB1D && r <= 0xFDFF) ||
        (r >= 0xFE70 && r <= 0xFEFF)) {
      return TextDirection.rtl;
    }
    if ((r >= 0x41 && r <= 0x5A) ||
        (r >= 0x61 && r <= 0x7A) ||
        (r >= 0xC0 && r <= 0x24F)) {
      return TextDirection.ltr;
    }
  }
  return null;
}

/// Flips the field under it to match what's typed: "hello" reads LTR,
/// "أهلاً" reads RTL.
class AutoDirection extends StatefulWidget {
  const AutoDirection({super.key, required this.controller, required this.child});

  final TextEditingController controller;
  final Widget child;

  @override
  State<AutoDirection> createState() => _AutoDirectionState();
}

class _AutoDirectionState extends State<AutoDirection> {
  TextDirection? _direction;

  @override
  void initState() {
    super.initState();
    _direction = detectTextDirection(widget.controller.text);
    widget.controller.addListener(_update);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_update);
    super.dispose();
  }

  void _update() {
    final d = detectTextDirection(widget.controller.text);
    if (d != _direction) setState(() => _direction = d);
  }

  @override
  Widget build(BuildContext context) {
    // Always a Directionality, so the field keeps its state (and focus) when
    // the direction flips.
    return Directionality(
      textDirection: _direction ?? Directionality.of(context),
      child: widget.child,
    );
  }
}
