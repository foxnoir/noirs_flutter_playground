import 'package:advanced_concepts/core/errors/app_failure_message.dart';
import 'package:advanced_concepts/core/router/app_router_names.dart';
import 'package:advanced_concepts/features/api_dio_lab/domain/entities/book.dart';
import 'package:advanced_concepts/features/api_dio_lab/presentation/providers/api_dio_lab_provider.dart';
import 'package:advanced_concepts/features/api_dio_lab/presentation/widgets/api_dio_lab_book_list.dart';
import 'package:advanced_concepts/features/api_dio_lab/presentation/widgets/api_dio_lab_book_sheet.dart';
import 'package:advanced_concepts/features/api_dio_lab/presentation/widgets/api_dio_lab_scenario_bar.dart';
import 'package:advanced_concepts/features/api_dio_lab/presentation/widgets/api_dio_lab_search_sheet.dart';
import 'package:advanced_concepts/features/api_lab_session/presentation/widgets/api_lab_session_button.dart';
import 'package:advanced_concepts/features/api_lab_session/presentation/widgets/api_lab_unauthorized_dialog.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/apis/api_lab_background.dart';
import 'package:advanced_concepts/shared_widgets/error_widget.dart' as app;
import 'package:advanced_concepts/shared_widgets/labs/lab_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ApiDioLabScreen extends ConsumerStatefulWidget {
  const ApiDioLabScreen({super.key});

  @override
  ConsumerState<ApiDioLabScreen> createState() => _ApiDioLabScreenState();
}

class _ApiDioLabScreenState extends ConsumerState<ApiDioLabScreen> {
  ApiDioLabScenario? _drill;

  void _snack(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _runDrill(ApiDioLabScenario scenario) async {
    setState(() => _drill = scenario);
    await ref.read(apiDioLabProvider.notifier).load(scenario);
    if (!mounted) return;
    if (!ref.read(apiDioLabProvider).hasError) {
      _snack(AppLocalizations.of(context).apiDioSnackGetBooks);
    }
  }

  Future<void> _fetchBooks({required bool snack}) async {
    setState(() => _drill = null);
    await ref.read(apiDioLabProvider.notifier).load(ApiDioLabScenario.books);
    if (!mounted) return;
    if (snack && !ref.read(apiDioLabProvider).hasError) {
      _snack(AppLocalizations.of(context).apiDioSnackGetBooks);
    }
  }

  Future<void> _deleteBook(Book book) async {
    final id = book.id;
    if (id == null) return;
    final l10n = AppLocalizations.of(context);
    final outcome = await showDialog<({bool deleted, Object? error})>(
      context: context,
      builder: (dialogContext) {
        var loading = false;
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return PopScope(
              canPop: !loading,
              child: AlertDialog(
                content: Text(l10n.apiDioConfirmDelete(book.title)),
                actions: [
                  TextButton(
                    onPressed: loading
                        ? null
                        : () => Navigator.of(dialogContext).pop(),
                    child: Text(
                      MaterialLocalizations.of(dialogContext).cancelButtonLabel,
                    ),
                  ),
                  FilledButton(
                    key: const Key('api-dio-lab-book-delete-confirm'),
                    onPressed: loading
                        ? null
                        : () async {
                            setDialogState(() => loading = true);
                            try {
                              await ref
                                  .read(apiDioLabProvider.notifier)
                                  .deleteBook(id);
                              if (dialogContext.mounted) {
                                Navigator.of(
                                  dialogContext,
                                ).pop((deleted: true, error: null));
                              }
                            } catch (error) {
                              if (!dialogContext.mounted) return;
                              if (await showUnauthorizedIfNeeded(
                                dialogContext,
                                error,
                                replaceCurrentDialog: true,
                              )) {
                                return;
                              }
                              Navigator.of(
                                dialogContext,
                              ).pop((deleted: false, error: error));
                            }
                          },
                    child: loading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.apiDioDelete),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    if (!mounted || outcome == null) return;
    if (outcome.deleted) {
      _snack(l10n.apiDioSnackDeleted(book.title));
      return;
    }
    final error = outcome.error;
    if (error == null) return;
    if (await showUnauthorizedIfNeeded(context, error)) return;
    _snack(localizedError(l10n, error));
  }

  void _showDetails(Book book) {
    final id = book.id;
    if (id == null) return;
    context.pushNamed(
      AppRouteNames.bookDetails,
      pathParameters: {'bookId': id},
      extra: book.title,
    );
  }

  Future<void> _openBookSheet({Book? book}) async {
    final result = await showApiDioLabBookSheet(context, book: book);
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
    final shelf = ref.watch(apiDioLabProvider);
    final searchActive = shelf.value?.searchActive ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.apiDio),
        actions: [
          if (searchActive)
            IconButton(
              key: const Key('api-dio-lab-search-clear'),
              tooltip: l10n.apiDioSearchClear,
              onPressed: () => _fetchBooks(snack: false),
              icon: const Icon(Icons.clear),
            )
          else
            IconButton(
              key: const Key('api-dio-lab-search'),
              tooltip: l10n.apiDioSearch,
              onPressed: () => showApiDioLabSearchSheet(context),
              icon: const Icon(Icons.search),
            ),
          IconButton(
            key: const Key('api-dio-lab-refresh'),
            tooltip: l10n.retry,
            onPressed: () => _fetchBooks(snack: true),
            icon: const Icon(Icons.refresh),
          ),
          const ApiLabSessionButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('api-dio-lab-add'),
        tooltip: l10n.apiDioAdd,
        onPressed: _openBookSheet,
        child: const Icon(Icons.add),
      ),
      body: ApiLabBackground(
        child: LabScreenBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ApiDioLabScenarioBar(selected: _drill, onSelect: _runDrill),
              Expanded(child: _body(l10n, shelf)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(AppLocalizations l10n, AsyncValue<ApiDioLabShelf> shelf) {
    return shelf.when(
      skipLoadingOnReload: false,
      skipLoadingOnRefresh: false,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: app.ErrorWidget(
          message: localizedError(l10n, error),
          retryLabel: l10n.retry,
          onRetry: () => _fetchBooks(snack: true),
        ),
      ),
      data: (value) => ApiDioLabBookList(
        books: value.books,
        onRefresh: () => _fetchBooks(snack: true),
        onOpen: _showDetails,
        onEdit: (book) => _openBookSheet(book: book),
        onDelete: _deleteBook,
      ),
    );
  }
}
