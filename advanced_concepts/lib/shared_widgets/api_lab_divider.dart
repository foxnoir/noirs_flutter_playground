import 'package:flutter/material.dart';

/// Full-width Victorian hairline between shelf rows.
class ApiLabDivider extends StatelessWidget {
  const ApiLabDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = scheme.onPrimaryContainer.withValues(alpha: 0.38);

    return SizedBox(
      width: double.infinity,
      height: 18,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: CustomPaint(painter: _VictorianFlourishPainter(color: color)),
      ),
    );
  }
}

class _VictorianFlourishPainter extends CustomPainter {
  const _VictorianFlourishPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final half = size.width / 2;

    canvas.save();
    canvas.translate(cx, cy);
    _paintArm(canvas, stroke, fill, half);
    canvas.scale(-1, 1);
    _paintArm(canvas, stroke, fill, half);
    canvas.restore();

    _paintFleuron(canvas, Offset(cx, cy), stroke, fill);
  }

  /// Right-hand arm in local space (origin at the divider center).
  void _paintArm(Canvas canvas, Paint stroke, Paint fill, double half) {
    final end = half - 2;

    final innerScroll = Path()
      ..moveTo(7, 0)
      ..cubicTo(8, -4.5, 14, -5, 15, -1)
      ..cubicTo(16, 2, 12, 3.8, 9, 1.5);

    final lowerScroll = Path()
      ..moveTo(11, 1)
      ..cubicTo(14, 4.5, 21, 4.2, 23, 0.4);

    final rule = Path()
      ..moveTo(15, 0)
      ..cubicTo(end * 0.38, -1.1, end * 0.72, 1.1, end - 6, 0);

    final terminal = Path()
      ..moveTo(end - 6, 0)
      ..cubicTo(end - 1.5, 0, end, -2.8, end - 3, -3.6)
      ..cubicTo(end - 6.5, -4.4, end - 5.5, -0.8, end - 3, -0.4);

    canvas.drawPath(innerScroll, stroke);
    canvas.drawPath(lowerScroll, stroke);
    canvas.drawPath(rule, stroke);
    canvas.drawPath(terminal, stroke);
    canvas.drawCircle(Offset(end - 3.2, -1.8), 0.65, fill);
    canvas.drawCircle(const Offset(13.5, -4.2), 0.6, fill);
  }

  void _paintFleuron(Canvas canvas, Offset c, Paint stroke, Paint fill) {
    final diamond = Path()
      ..moveTo(c.dx, c.dy - 3.4)
      ..lineTo(c.dx + 2.4, c.dy)
      ..lineTo(c.dx, c.dy + 3.4)
      ..lineTo(c.dx - 2.4, c.dy)
      ..close();
    canvas.drawPath(diamond, stroke);

    final inner = Path()
      ..moveTo(c.dx, c.dy - 1.4)
      ..lineTo(c.dx + 1, c.dy)
      ..lineTo(c.dx, c.dy + 1.4)
      ..lineTo(c.dx - 1, c.dy)
      ..close();
    canvas.drawPath(inner, fill);
  }

  @override
  bool shouldRepaint(covariant _VictorianFlourishPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
