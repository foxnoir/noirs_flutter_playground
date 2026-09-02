import 'package:flutter/material.dart';

/// Full-bleed cloud background for the books shelf and details.
class ApiLabBackground extends StatelessWidget {
  const ApiLabBackground({required this.child, super.key});

  static const asset = 'assets/img/bg.webp';

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(asset),
          fit: BoxFit.cover,
          opacity: 0.35,
        ),
      ),
      child: child,
    );
  }
}
