part of 'book_metadata.dart';

class Ebook extends BookMetadata {
  const Ebook({
    required super.title,
    required super.author,
    required this.megabytes,
  });

  final int megabytes;

  @override
  bool operator ==(Object other) {
    return other is Ebook &&
        other.title == title &&
        other.author == author &&
        other.megabytes == megabytes;
  }

  @override
  int get hashCode => Object.hash(title, author, megabytes);
}
