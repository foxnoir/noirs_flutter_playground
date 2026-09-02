import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/core/errors/app_failure.dart';
import 'package:advanced_concepts/features/api_dio_lab/data/data_sources/api_dio_lab_data_source.dart';
import 'package:advanced_concepts/features/api_dio_lab/data/models/book_model.dart';
import 'package:advanced_concepts/features/api_dio_lab/domain/entities/book.dart';
import 'package:advanced_concepts/features/api_dio_lab/domain/repositories/api_dio_lab_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiDioLabRepositoryProvider = Provider<ApiDioLabRepository>((ref) {
  return DioApiDioLabRepository(ref.watch(apiDioLabDataSourceProvider));
});

/// Maps models → entities and AppException → AppFailure.
class DioApiDioLabRepository implements ApiDioLabRepository {
  const DioApiDioLabRepository(this._dataSource);

  final ApiDioLabDataSource _dataSource;

  @override
  Future<Book> fetchSuccess() {
    return _map(_dataSource.fetchSuccess);
  }

  @override
  Future<void> fetchError() async {
    try {
      await _dataSource.fetchError();
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  @override
  Future<Book> fetchTimeout({Duration? timeout}) {
    return _map(() => _dataSource.fetchTimeout(timeout: timeout));
  }

  @override
  Future<void> fetchOffline() async {
    try {
      await _dataSource.fetchOffline();
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  @override
  Future<List<Book>> fetchBooks() async {
    try {
      final models = await _dataSource.fetchBooks();
      return [for (final model in models) model.toEntity()];
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  @override
  Future<Book> search({required String title, required String author}) {
    return _map(() => _dataSource.search(title: title, author: author));
  }

  @override
  Future<Book> addBook(Book book) {
    return _map(() => _dataSource.addBook(_toModel(book)));
  }

  @override
  Future<Book> updateBook(Book book) {
    return _map(() => _dataSource.updateBook(_toModel(book)));
  }

  @override
  Future<void> deleteBook(String id) async {
    try {
      await _dataSource.deleteBook(id);
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  BookModel _toModel(Book book) {
    return BookModel(
      id: book.id,
      title: book.title,
      author: book.author,
      status: book.status,
    );
  }

  Future<Book> _map(Future<BookModel> Function() call) async {
    try {
      final model = await call();
      return model.toEntity();
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }
}
