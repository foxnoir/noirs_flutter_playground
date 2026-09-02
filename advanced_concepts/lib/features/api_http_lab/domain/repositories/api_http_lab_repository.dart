import 'package:advanced_concepts/features/api_http_lab/domain/entities/book.dart';

/// Throws AppFailure when the data source failed.
abstract interface class ApiHttpLabRepository {
  Future<Book> fetchSuccess();

  Future<void> fetchError();

  Future<Book> fetchTimeout({Duration? timeout});

  Future<void> fetchOffline();

  Future<List<Book>> fetchBooks();

  Future<Book> search({required String title, required String author});

  Future<Book> addBook(Book book);

  Future<Book> updateBook(Book book);

  Future<void> deleteBook(String id);
}
