import 'package:advanced_concepts/features/api_http_lab/domain/entities/book.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

String apiHttpLabStatusLabel(AppLocalizations l10n, BookStatus status) {
  return switch (status) {
    BookStatus.notStarted => l10n.apiDioNotStarted,
    BookStatus.reading => l10n.apiDioReading,
    BookStatus.finished => l10n.apiDioFinished,
  };
}

abstract final class ApiHttpLabIcons {
  static const book = 'assets/img/icons/books/book_turquise.png';
  static const edit = 'assets/img/icons/edit.png';
  static const delete = 'assets/img/icons/delete.png';
}

class ApiHttpLabAssetIcon extends StatelessWidget {
  const ApiHttpLabAssetIcon(this.asset, {this.size = 28, super.key});

  final String asset;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(asset, width: size, height: size, fit: BoxFit.contain);
  }
}

class ApiHttpLabStatusLabel extends StatelessWidget {
  const ApiHttpLabStatusLabel({required this.status, super.key});

  final BookStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
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

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          apiHttpLabStatusLabel(AppLocalizations.of(context), status),
          style: theme.textTheme.labelSmall?.copyWith(color: foreground),
        ),
      ),
    );
  }
}

class ApiHttpLabBookTile extends StatelessWidget {
  const ApiHttpLabBookTile({
    required this.book,
    required this.onOpen,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final Book book;
  final VoidCallback onOpen;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return InkWell(
      key: Key('api-http-lab-book-${book.id}'),
      onTap: onOpen,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Row(
          children: [
            ApiHttpLabAssetIcon(
              ApiHttpLabIcons.book,
              key: Key('api-http-lab-open-${book.id}'),
              size: 40,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    book.author,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ApiHttpLabStatusLabel(status: book.status),
            const SizedBox(width: 12),
            IconButton(
              key: Key('api-http-lab-edit-${book.id}'),
              tooltip: l10n.apiDioEdit,
              style: IconButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
                minimumSize: const Size(32, 32),
                visualDensity: VisualDensity.compact,
              ),
              onPressed: onEdit,
              icon: const ApiHttpLabAssetIcon(ApiHttpLabIcons.edit),
            ),
            IconButton(
              key: Key('api-http-lab-delete-${book.id}'),
              tooltip: l10n.apiDioDelete,
              style: IconButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
                minimumSize: const Size(32, 32),
                visualDensity: VisualDensity.compact,
              ),
              onPressed: onDelete,
              icon: const ApiHttpLabAssetIcon(ApiHttpLabIcons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
