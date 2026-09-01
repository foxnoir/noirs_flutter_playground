import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/core/errors/app_failure.dart';
import 'package:advanced_concepts/features/api_integration_lab/data/data_sources/book_api_data_source.dart';
import 'package:advanced_concepts/features/api_integration_lab/data/models/book_model.dart';
import 'package:advanced_concepts/features/api_integration_lab/domain/entities/book.dart';
import 'package:advanced_concepts/features/api_integration_lab/domain/repositories/book_api_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookApiRepositoryProvider = Provider<BookApiRepository>((ref) {
  return HttpBookApiRepository(ref.watch(bookApiDataSourceProvider));
});

/// Maps models → entities and AppException → AppFailure.
class HttpBookApiRepository implements BookApiRepository {
  const HttpBookApiRepository(this._dataSource);

  final BookApiDataSource _dataSource;

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
  Future<Book> identify({required String title, required String author}) {
    return _map(() => _dataSource.identify(title: title, author: author));
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
