part of 'book_metadata.dart';

class Hardcover extends BookMetadata {
  const Hardcover({
    required super.title,
    required super.author,
    required this.pages,
  });

  final int pages;

  @override
  bool operator ==(Object other) {
    return other is Hardcover &&
        other.title == title &&
        other.author == author &&
        other.pages == pages;
  }

  @override
  int get hashCode => Object.hash(title, author, pages);
}
