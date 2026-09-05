import 'package:advanced_concepts/features/sealed_lab/domain/entities/book_metadata.dart';

/// Throws AppFailure when the data source failed.
// ignore: one_member_abstracts — one GET; tests swap the fake
abstract interface class SealedLabRepository {
  Future<List<BookMetadata>> fetchFormats();
}
