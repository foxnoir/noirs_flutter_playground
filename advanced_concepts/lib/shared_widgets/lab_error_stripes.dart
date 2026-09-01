import 'package:flutter/material.dart';

/// Flutter-debug overflow look, without throwing so the lab page stays up.
class LabErrorStripes extends StatelessWidget {
  const LabErrorStripes({required this.message, super.key});

  final String message;

  static const height = 108.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: const _LabErrorStripePainter(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                shadows: const [Shadow(blurRadius: 4)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LabErrorStripePainter extends CustomPainter {
  const _LabErrorStripePainter();

  static const _yellow = Color(0xBFFFFF00);
  static const _black = Color(0xE6000000);

  @override
  void paint(Canvas canvas, Size size) {
    const stripe = 10.0;
    final yellow = Paint()..color = _yellow;
    final black = Paint()..color = _black;
    canvas.drawRect(Offset.zero & size, black);
    for (var x = -size.height; x < size.width + size.height; x += stripe * 2) {
      final path = Path()
        ..moveTo(x, size.height)
        ..lineTo(x + stripe, size.height)
        ..lineTo(x + stripe + size.height, 0)
        ..lineTo(x + size.height, 0)
        ..close();
      canvas.drawPath(path, yellow);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
