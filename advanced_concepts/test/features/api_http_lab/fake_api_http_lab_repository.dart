import 'package:advanced_concepts/core/errors/app_failure.dart';
import 'package:advanced_concepts/features/api_http_lab/domain/entities/book.dart';
import 'package:advanced_concepts/features/api_http_lab/domain/repositories/api_http_lab_repository.dart';

class FakeApiHttpLabRepository implements ApiHttpLabRepository {
  FakeApiHttpLabRepository({
    List<Book> books = const [],
    this.error,
    this.searchError,
    this.match,
  }) : books = List<Book>.of(books);

  final List<Book> books;
  final AppFailure? error;
  final AppFailure? searchError;
  final Book? match;

  @override
  Future<Book> fetchSuccess() async {
    return _throwOr(books.isEmpty ? _fallback : books.first);
  }

  @override
  Future<void> fetchError() async {
    throw error ?? const ServerFailure();
  }

  @override
  Future<Book> fetchTimeout({Duration? timeout}) async {
    throw error ?? const TimeoutFailure();
  }

  @override
  Future<void> fetchOffline() async {
    throw error ?? const NetworkFailure();
  }

  @override
  Future<List<Book>> fetchBooks() async {
    return List<Book>.of(_throwOr(books));
  }

  @override
  Future<Book> search({required String title, required String author}) async {
    final thrown = searchError;
    if (thrown != null) {
      throw thrown;
    }
    final match = this.match;
    if (match != null && match.title == title && match.author == author) {
      return match;
    }
    throw const UnauthorizedFailure();
  }

  @override
  Future<Book> addBook(Book book) async {
    _throwIfError();
    final created = book.copyWith(id: '${books.length + 10}');
    books.add(created);
    return created;
  }

  @override
  Future<Book> updateBook(Book book) async {
    _throwIfError();
    final index = books.indexWhere((entry) => entry.id == book.id);
    if (index < 0) {
      throw const NotFoundFailure();
    }
    books[index] = book;
    return book;
  }

  @override
  Future<void> deleteBook(String id) async {
    _throwIfError();
    books.removeWhere((entry) => entry.id == id);
  }

  T _throwOr<T>(T value) {
    _throwIfError();
    return value;
  }

  void _throwIfError() {
    final thrown = error;
    if (thrown != null) {
      throw thrown;
    }
  }

  static const _fallback = Book(
    id: '0',
    title: '',
    author: '',
    status: BookStatus.notStarted,
  );
}
