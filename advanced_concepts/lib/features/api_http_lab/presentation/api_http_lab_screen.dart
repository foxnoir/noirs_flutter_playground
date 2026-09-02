import 'package:advanced_concepts/core/errors/app_failure_message.dart';
import 'package:advanced_concepts/core/router/app_router_names.dart';
import 'package:advanced_concepts/features/api_http_lab/domain/entities/book.dart';
import 'package:advanced_concepts/features/api_http_lab/presentation/providers/api_http_lab_provider.dart';
import 'package:advanced_concepts/features/api_http_lab/presentation/widgets/api_http_lab_book_sheet.dart';
import 'package:advanced_concepts/features/api_http_lab/presentation/widgets/api_http_lab_book_tile.dart';
import 'package:advanced_concepts/features/api_http_lab/presentation/widgets/api_http_lab_scenario_bar.dart';
import 'package:advanced_concepts/features/api_http_lab/presentation/widgets/api_http_lab_search_sheet.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/error_widget.dart' as app;
import 'package:advanced_concepts/shared_widgets/lab_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Bookshelf UI is copied from Example Dio on purpose.
/// Sharing widgets would mix `package:http` and Dio in one feature.
/// That is not how a real app is structured — pick one client there.
class ApiHttpLabScreen extends ConsumerStatefulWidget {
  const ApiHttpLabScreen({super.key});

  @override
  ConsumerState<ApiHttpLabScreen> createState() => _ApiHttpLabScreenState();
}

class _ApiHttpLabScreenState extends ConsumerState<ApiHttpLabScreen> {
  ApiHttpLabScenario? _drill;

  void _snack(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _runDrill(ApiHttpLabScenario scenario) async {
    setState(() => _drill = scenario);
    await ref.read(apiHttpLabProvider.notifier).load(scenario);
    if (!mounted) return;
    if (!ref.read(apiHttpLabProvider).hasError) {
      _snack(AppLocalizations.of(context).apiDioSnackGetBooks);
    }
  }

  Future<void> _loadShelf({required bool snack}) async {
    setState(() => _drill = null);
    await ref.read(apiHttpLabProvider.notifier).load(ApiHttpLabScenario.books);
    if (!mounted) return;
    if (snack && !ref.read(apiHttpLabProvider).hasError) {
      _snack(AppLocalizations.of(context).apiDioSnackGetBooks);
    }
  }

  Future<void> _deleteBook(Book book) async {
    final id = book.id;
    if (id == null) return;
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(l10n.apiDioConfirmDelete(book.title)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
            FilledButton(
              key: const Key('api-http-lab-book-delete-confirm'),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.apiDioDelete),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !mounted) return;
    try {
      await ref.read(apiHttpLabProvider.notifier).deleteBook(id);
      if (!mounted) return;
      _snack(l10n.apiDioSnackDeleted(book.title));
    } catch (error) {
      if (!mounted) return;
      _snack(localizedError(l10n, error));
    }
  }

  void _openBook(Book book) {
    final id = book.id;
    if (id == null) return;
    context.pushNamed(
      AppRouteNames.httpBookDetails,
      pathParameters: {'bookId': id},
      extra: book.title,
    );
  }

  Future<void> _openBookSheet({Book? book}) async {
    final result = await showApiHttpLabBookSheet(context, book: book);
    if (!mounted || result == null) return;
    final l10n = AppLocalizations.of(context);
    final (action, title) = result;
    _snack(switch (action) {
      'added' => l10n.apiDioSnackAdded(title),
      'updated' => l10n.apiDioSnackUpdated(title),
      'deleted' => l10n.apiDioSnackDeleted(title),
      _ => title,
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final books = ref.watch(apiHttpLabProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.apiHttp),
        actions: [
          IconButton(
            key: const Key('api-http-lab-search'),
            tooltip: l10n.apiDioSearch,
            onPressed: () => showApiHttpLabSearchSheet(context),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            key: const Key('api-http-lab-refresh'),
            tooltip: l10n.retry,
            onPressed: () => _loadShelf(snack: true),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('api-http-lab-add'),
        tooltip: l10n.apiDioAdd,
        onPressed: _openBookSheet,
        child: const Icon(Icons.add),
      ),
      body: LabScreenBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ApiHttpLabScenarioBar(selected: _drill, onSelect: _runDrill),
            Expanded(child: _body(l10n, books)),
          ],
        ),
      ),
    );
  }

  Widget _body(AppLocalizations l10n, AsyncValue<List<Book>> books) {
    if (books.hasError) {
      return Center(
        child: app.ErrorWidget(
          message: localizedError(l10n, books.error!),
          retryLabel: l10n.retry,
          onRetry: () => _loadShelf(snack: true),
        ),
      );
    }
    if (books.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return _ApiHttpLabBookList(
      books: books.requireValue,
      onRefresh: () => _loadShelf(snack: true),
      onOpen: _openBook,
      onEdit: (book) => _openBookSheet(book: book),
      onDelete: _deleteBook,
    );
  }
}

class _ApiHttpLabBookList extends StatelessWidget {
  const _ApiHttpLabBookList({
    required this.books,
    required this.onRefresh,
    required this.onOpen,
    required this.onEdit,
    required this.onDelete,
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
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ApiHttpLabBookTile(
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
