import 'package:flutter/material.dart' hide ErrorWidget;

/// Illustration plus a localized message for async error UI.
///
/// Import material with `hide ErrorWidget` so this name does not clash
/// with Flutter's build-failure fallback.
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    required this.message,
    this.retryLabel,
    this.onRetry,
    this.imageAsset = defaultImageAsset,
    super.key,
  });

  static const defaultImageAsset = 'assets/img/error_dragon.png';

  final String message;
  final String? retryLabel;
  final VoidCallback? onRetry;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final retryLabel = this.retryLabel;
    final onRetry = this.onRetry;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(imageAsset, width: 220, fit: BoxFit.contain),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge,
          ),
        ),
        if (onRetry != null && retryLabel != null) ...[
          const SizedBox(height: 24),
          FilledButton(onPressed: onRetry, child: Text(retryLabel)),
        ],
      ],
    );
  }
}
