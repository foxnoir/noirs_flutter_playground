import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Flat turquoise book. Count sits on the cover. No depth, no ornament.
class GenericsExampleBooksReadIcon extends StatelessWidget {
  const GenericsExampleBooksReadIcon(this.count, {super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final cover = scheme.secondary;
    final spine = Color.alphaBlend(
      scheme.onSecondary.withValues(alpha: 0.22),
      cover,
    );

    return Tooltip(
      message: l10n.genericsExampleBooksRead,
      child: Semantics(
        label: l10n.genericsExampleBooksReadCount(count),
        child: SizedBox(
          width: 40,
          height: 48,
          child: CustomPaint(
            painter: _FlatBookPainter(
              cover: cover,
              spine: spine,
              ribbon: cover,
            ),
            child: Align(
              alignment: const Alignment(0.22, -0.08),
              child: Text(
                '$count',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: scheme.onSecondary,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FlatBookPainter extends CustomPainter {
  const _FlatBookPainter({
    required this.cover,
    required this.spine,
    required this.ribbon,
  });

  final Color cover;
  final Color spine;
  final Color ribbon;

  @override
  void paint(Canvas canvas, Size size) {
    const radius = Radius.circular(3);
    final coverHeight = size.height - 7;
    final coverRect = Rect.fromLTWH(0, 0, size.width, coverHeight);

    canvas.drawRRect(
      RRect.fromRectAndRadius(coverRect, radius),
      Paint()..color = cover,
    );

    final spineWidth = size.width * 0.22;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, spineWidth, coverHeight),
        topLeft: radius,
        bottomLeft: radius,
      ),
      Paint()..color = spine,
    );

    final cx = size.width * 0.62;
    const half = 3.5;
    final ribbonPath = Path()
      ..moveTo(cx - half, coverHeight - 2)
      ..lineTo(cx + half, coverHeight - 2)
      ..lineTo(cx + half, size.height)
      ..lineTo(cx, size.height - 4)
      ..lineTo(cx - half, size.height)
      ..close();
    canvas.drawPath(ribbonPath, Paint()..color = ribbon);
  }

  @override
  bool shouldRepaint(covariant _FlatBookPainter oldDelegate) {
    return oldDelegate.cover != cover ||
        oldDelegate.spine != spine ||
        oldDelegate.ribbon != ribbon;
  }
}
