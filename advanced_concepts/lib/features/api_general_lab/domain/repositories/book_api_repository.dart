import 'package:advanced_concepts/features/api_general_lab/domain/entities/book.dart';

/// Throws AppFailure when the data source failed.
abstract interface class BookApiRepository {
  Future<Book> fetchSuccess();

  Future<void> fetchError();

  Future<Book> fetchTimeout({Duration? timeout});

  Future<void> fetchOffline();

  Future<List<Book>> fetchBooks();

  Future<Book> identify({required String title, required String author});
}
