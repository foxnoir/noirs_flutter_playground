import 'package:advanced_concepts/features/api_dio_lab/domain/entities/book.dart';
import 'package:advanced_concepts/features/api_dio_lab/presentation/widgets/api_dio_lab_book_tile.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/apis/api_lab_divider.dart';
import 'package:flutter/material.dart';

class ApiDioLabBookList extends StatelessWidget {
  const ApiDioLabBookList({
    required this.books,
    required this.onRefresh,
    required this.onOpen,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final List<Book> books;
  final Future<void> Function() onRefresh;
  final ValueChanged<Book> onOpen;
  final ValueChanged<Book> onEdit;
  final ValueChanged<Book> onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (books.isEmpty) {
      return Center(
        child: Text(
          l10n.apiDioEmpty,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: books.length,
        separatorBuilder: (context, _) => const ApiLabDivider(),
        itemBuilder: (context, index) {
          final book = books[index];
          return ApiDioLabBookTile(
            book: book,
            onOpen: () => onOpen(book),
            onEdit: () => onEdit(book),
            onDelete: () => onDelete(book),
          );
        },
      ),
    );
  }
}
