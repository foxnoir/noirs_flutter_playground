import 'package:meta/meta.dart';

part 'hardcover.dart';
part 'paperback.dart';
part 'ebook.dart';

/// Title and author only. Not the API book entity or BookModel.
/// Hardcover, Paperback, and Ebook are the formats — they extend this.
@immutable
sealed class BookMetadata {
  const BookMetadata({required this.title, required this.author});

  final String title;
  final String author;
}
