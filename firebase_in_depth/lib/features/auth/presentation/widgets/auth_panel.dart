import 'package:flutter/material.dart';

class AuthPanel extends StatelessWidget {
  const AuthPanel({this.compact = false, super.key});

  static const asset = 'assets/img/auth_dragon.png';
  static const stackHeight = 580.0;

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scheme = Theme.of(context).colorScheme;
        final width = constraints.maxWidth;
        final height = compact
            ? 280.0
            : (constraints.maxHeight.isFinite
                  ? constraints.maxHeight
                  : stackHeight);
        final frameWidth = width * (compact ? 0.72 : 0.92);
        final frameHeight = compact ? 188.0 : height * 0.74;
        final imageWidth = (frameWidth * 1.06).clamp(0.0, width - 8);
        final frameBottom = (height - frameHeight) / 2;

        return SizedBox(
          height: height,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Center(
                child: SizedBox(
                  key: const Key('auth-panel-frame'),
                  width: frameWidth,
                  height: frameHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: (width - imageWidth) / 2,
                width: imageWidth,
                bottom: frameBottom + 10,
                child: ExcludeSemantics(
                  child: IgnorePointer(
                    child: Image.asset(
                      asset,
                      key: const Key('auth-panel'),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
