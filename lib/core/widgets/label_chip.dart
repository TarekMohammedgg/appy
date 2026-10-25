import 'package:flutter/widgets.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';

/// "#appy" reads LTR, "#بيت" reads RTL, so "#" always sits before the word.
String labelText(String label) {
  final latin = RegExp(r'^[A-Za-z0-9]').hasMatch(label);
  // LRI/RLI … PDI isolate the run from the surrounding paragraph direction.
  return latin ? '\u{2066}#$label\u{2069}' : '\u{2067}#$label\u{2069}';
}

/// Accepted label: "#appy" in a grey pill.
class LabelChip extends StatelessWidget {
  const LabelChip(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: c.fill3,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(labelText(label), style: AppText.footnote.copyWith(color: c.ink2)),
    );
  }
}

/// AI-suggested label: dashed gold outline until the user accepts it.
class SuggestedLabelChip extends StatelessWidget {
  const SuggestedLabelChip(
    this.label, {
    super.key,
    required this.onAccept,
    required this.onReject,
  });

  final String label;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      button: true,
      label: 'اقتراح: $label. اضغط للقبول، اضغط مطولًا للرفض',
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onAccept,
        onLongPress: onReject,
        child: CustomPaint(
          painter: _DashedPillPainter(c.accentStrong),
          child: Padding(
            padding:
                const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 4),
            child: Text(labelText(label),
                style: AppText.footnote.copyWith(color: c.accentStrong)),
          ),
        ),
      ),
    );
  }
}

class _DashedPillPainter extends CustomPainter {
  _DashedPillPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final rrect = RRect.fromRectAndRadius(
      (Offset.zero & size).deflate(0.5),
      Radius.circular(size.height / 2),
    );
    for (final metric in (Path()..addRRect(rrect)).computeMetrics()) {
      for (double d = 0; d < metric.length; d += 6) {
        canvas.drawPath(metric.extractPath(d, d + 3), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DashedPillPainter old) => old.color != color;
}
