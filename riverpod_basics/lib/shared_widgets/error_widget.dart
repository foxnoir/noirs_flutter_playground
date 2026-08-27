import 'package:flutter/material.dart' hide ErrorWidget;

/// Illustration plus a localized message.
///
/// Async errors use [defaultImageAsset]. User Search uses
/// [notFoundImageAsset] when the filter matches nobody.
///
/// Import material with `hide ErrorWidget` so this name does not clash
/// with Flutter's build-failure fallback.
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    required this.message,
    this.imageAsset = defaultImageAsset,
    super.key,
  });

  static const defaultImageAsset = 'assets/img/error_dragon.png';
  static const notFoundImageAsset = 'assets/img/not_found_dragon.png';

  final String message;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageAsset, width: 280, fit: BoxFit.contain),
          const SizedBox(height: 24),
          Text(
            message,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
