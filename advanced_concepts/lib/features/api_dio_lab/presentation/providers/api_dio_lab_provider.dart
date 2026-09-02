import 'package:advanced_concepts/features/api_dio_lab/data/repositories/api_dio_lab_repository.dart';
import 'package:advanced_concepts/features/api_dio_lab/domain/entities/book.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ApiDioLabScenario { books, unstable, timeout, offline, serverError }

class ApiDioLabShelf {
  const ApiDioLabShelf({required this.books, this.searchActive = false});

  final List<Book> books;
  final bool searchActive;
}

final apiDioLabProvider =
    AsyncNotifierProvider<ApiDioLabNotifier, ApiDioLabShelf>(
      ApiDioLabNotifier.new,
      // Riverpod 3 retries build() failures and keeps isLoading; when() then
      // shows a spinner instead of the error. The lab must surface the failure.
      retry: (_, _) => null,
    );

class ApiDioLabNotifier extends AsyncNotifier<ApiDioLabShelf> {
  static const _guardedTimeout = Duration(milliseconds: 400);

  var _unstableLoads = 0;

  @override
  Future<ApiDioLabShelf> build() async {
    return ApiDioLabShelf(books: await _fetch(ApiDioLabScenario.books));
  }

  Future<void> load(ApiDioLabScenario scenario) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ApiDioLabShelf(books: await _fetch(scenario));
    });
  }

  Future<Book> search({required String title, required String author}) async {
    final book = await ref
        .read(apiDioLabRepositoryProvider)
        .search(title: title, author: author);
    state = AsyncData(ApiDioLabShelf(books: [book], searchActive: true));
    return book;
  }

  Future<Book> addBook(Book book) async {
    final created = await ref.read(apiDioLabRepositoryProvider).addBook(book);
    await _syncBooks();
    return created;
  }

  Future<Book> updateBook(Book book) async {
    final updated = await ref
        .read(apiDioLabRepositoryProvider)
        .updateBook(book);
    await _syncBooks();
    return updated;
  }

  Future<void> deleteBook(String id) async {
    await ref.read(apiDioLabRepositoryProvider).deleteBook(id);
    await _syncBooks();
  }

  Future<void> _syncBooks() async {
    try {
      state = AsyncData(
        ApiDioLabShelf(
          books: await ref.read(apiDioLabRepositoryProvider).fetchBooks(),
        ),
      );
    } on Object catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<List<Book>> _fetch(ApiDioLabScenario selected) {
    final repo = ref.read(apiDioLabRepositoryProvider);
    final scenario = _effective(selected);
    return switch (scenario) {
      ApiDioLabScenario.books ||
      ApiDioLabScenario.unstable => repo.fetchBooks(),
      ApiDioLabScenario.timeout =>
        repo.fetchTimeout(timeout: _guardedTimeout).then((_) => <Book>[]),
      ApiDioLabScenario.offline => repo.fetchOffline().then((_) => <Book>[]),
      ApiDioLabScenario.serverError => repo.fetchError().then((_) => <Book>[]),
    };
  }

  ApiDioLabScenario _effective(ApiDioLabScenario selected) {
    if (selected != ApiDioLabScenario.unstable) {
      return selected;
    }
    _unstableLoads += 1;
    if (_unstableLoads % 3 != 0) {
      return ApiDioLabScenario.books;
    }
    return switch ((_unstableLoads ~/ 3) % 3) {
      1 => ApiDioLabScenario.timeout,
      2 => ApiDioLabScenario.offline,
      _ => ApiDioLabScenario.serverError,
    };
  }
}
