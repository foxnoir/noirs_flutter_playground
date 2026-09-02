import 'package:advanced_concepts/features/api_http_lab/data/repositories/api_http_lab_repository.dart';
import 'package:advanced_concepts/features/api_http_lab/domain/entities/book.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ApiHttpLabScenario { books, unstable, timeout, offline, serverError }

class ApiHttpLabShelf {
  const ApiHttpLabShelf({required this.books, this.searchActive = false});

  final List<Book> books;
  final bool searchActive;
}

final apiHttpLabProvider =
    AsyncNotifierProvider<ApiHttpLabNotifier, ApiHttpLabShelf>(
      ApiHttpLabNotifier.new,
      // Riverpod 3 retries build() failures and keeps isLoading; when() then
      // shows a spinner instead of the error. The lab must surface the failure.
      retry: (_, _) => null,
    );

class ApiHttpLabNotifier extends AsyncNotifier<ApiHttpLabShelf> {
  static const _guardedTimeout = Duration(milliseconds: 400);

  var _unstableLoads = 0;

  @override
  Future<ApiHttpLabShelf> build() async {
    return ApiHttpLabShelf(books: await _fetch(ApiHttpLabScenario.books));
  }

  Future<void> load(ApiHttpLabScenario scenario) async {
    state = const AsyncLoading<ApiHttpLabShelf>();
    state = await AsyncValue.guard(() async {
      return ApiHttpLabShelf(books: await _fetch(scenario));
    });
  }

  Future<Book> search({required String title, required String author}) async {
    final book = await ref
        .read(apiHttpLabRepositoryProvider)
        .search(title: title, author: author);
    state = AsyncData(ApiHttpLabShelf(books: [book], searchActive: true));
    return book;
  }

  Future<Book> addBook(Book book) async {
    final created = await ref.read(apiHttpLabRepositoryProvider).addBook(book);
    await _syncBooks();
    return created;
  }

  Future<Book> updateBook(Book book) async {
    final updated = await ref
        .read(apiHttpLabRepositoryProvider)
        .updateBook(book);
    await _syncBooks();
    return updated;
  }

  Future<void> deleteBook(String id) async {
    await ref.read(apiHttpLabRepositoryProvider).deleteBook(id);
    await _syncBooks();
  }

  Future<void> _syncBooks() async {
    try {
      state = AsyncData(
        ApiHttpLabShelf(
          books: await ref.read(apiHttpLabRepositoryProvider).fetchBooks(),
        ),
      );
    } on Object catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<List<Book>> _fetch(ApiHttpLabScenario selected) {
    final repo = ref.read(apiHttpLabRepositoryProvider);
    final scenario = _effective(selected);
    return switch (scenario) {
      ApiHttpLabScenario.books ||
      ApiHttpLabScenario.unstable => repo.fetchBooks(),
      ApiHttpLabScenario.timeout =>
        repo.fetchTimeout(timeout: _guardedTimeout).then((_) => <Book>[]),
      ApiHttpLabScenario.offline => repo.fetchOffline().then((_) => <Book>[]),
      ApiHttpLabScenario.serverError => repo.fetchError().then((_) => <Book>[]),
    };
  }

  ApiHttpLabScenario _effective(ApiHttpLabScenario selected) {
    if (selected != ApiHttpLabScenario.unstable) {
      return selected;
    }
    _unstableLoads += 1;
    if (_unstableLoads % 3 != 0) {
      return ApiHttpLabScenario.books;
    }
    return switch ((_unstableLoads ~/ 3) % 3) {
      1 => ApiHttpLabScenario.timeout,
      2 => ApiHttpLabScenario.offline,
      _ => ApiHttpLabScenario.serverError,
    };
  }
}
