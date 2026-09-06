import 'package:flutter/material.dart' hide ErrorWidget;

/// Icon plus a localized message for async error UI.
///
/// Import material with `hide ErrorWidget` so this name does not clash
/// with Flutter's build-failure fallback.
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    required this.message,
    this.retryLabel,
    this.onRetry,
    super.key,
  });

  final String message;
  final String? retryLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final retryLabel = this.retryLabel;
    final onRetry = this.onRetry;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 72,
            color: Theme.of(context).colorScheme.error,
          ),
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
      ),
    );
  }
}
