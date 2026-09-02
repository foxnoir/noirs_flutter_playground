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
  static const book = 'assets/img/icons/book.png';
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

    return ListTile(
      key: Key('api-http-lab-book-${book.id}'),
      onTap: onOpen,
      minLeadingWidth: 40,
      horizontalTitleGap: 8,
      leading: ApiHttpLabAssetIcon(
        ApiHttpLabIcons.book,
        key: Key('api-http-lab-open-${book.id}'),
        size: 40,
      ),
      title: Text(book.title),
      subtitle: Text(book.author),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              apiHttpLabStatusLabel(l10n, book.status),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          IconButton(
            key: Key('api-http-lab-edit-${book.id}'),
            tooltip: l10n.apiDioEdit,
            visualDensity: VisualDensity.compact,
            onPressed: onEdit,
            icon: const ApiHttpLabAssetIcon(ApiHttpLabIcons.edit),
          ),
          IconButton(
            key: Key('api-http-lab-delete-${book.id}'),
            tooltip: l10n.apiDioDelete,
            visualDensity: VisualDensity.compact,
            onPressed: onDelete,
            icon: const ApiHttpLabAssetIcon(ApiHttpLabIcons.delete),
          ),
        ],
      ),
    );
  }
}
