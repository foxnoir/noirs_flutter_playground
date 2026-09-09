import 'package:flutter/material.dart';

/// Full-bleed `bg.webp` behind every DesktopScaffold.
class AppBackground extends StatelessWidget {
  const AppBackground({required this.child, super.key});

  static const asset = 'assets/img/bg.webp';

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      fit: StackFit.expand,
      children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(asset),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: ColoredBox(color: scheme.surface.withValues(alpha: 0.62)),
        ),
        child,
      ],
    );
  }
}
