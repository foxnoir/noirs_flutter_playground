import 'package:advanced_concepts/features/api_http_lab/domain/entities/book.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Two text slots plus leading and trailing. Not generic — the list is.
class GenericsExampleRow extends StatelessWidget {
  const GenericsExampleRow({
    required this.title,
    required this.subtitle,
    required this.leading,
    required this.trailing,
    super.key,
  });

  final String title;
  final String subtitle;
  final Widget leading;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      child: Row(
        children: [
          leading,
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                    height: 1.2,
                  ),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          trailing,
        ],
      ),
    );
  }
}

class GenericsExampleStatusChip extends StatelessWidget {
  const GenericsExampleStatusChip({required this.status, super.key});

  final BookStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final (background, foreground) = switch (status) {
      BookStatus.notStarted => (scheme.errorContainer, scheme.onError),
      BookStatus.reading => (
        scheme.primaryContainer,
        scheme.onPrimaryContainer,
      ),
      BookStatus.finished => (
        scheme.secondaryContainer,
        scheme.onSecondaryContainer,
      ),
    };
    final label = switch (status) {
      BookStatus.notStarted => l10n.apiDioNotStarted,
      BookStatus.reading => l10n.apiDioReading,
      BookStatus.finished => l10n.apiDioFinished,
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(color: foreground),
        ),
      ),
    );
  }
}
