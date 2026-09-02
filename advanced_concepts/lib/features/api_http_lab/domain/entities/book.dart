import 'package:meta/meta.dart';

enum BookStatus { notStarted, reading, finished }

@immutable
class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.status,
  });

  final String? id;
  final String title;
  final String author;
  final BookStatus status;

  Book copyWith({
    String? id,
    String? title,
    String? author,
    BookStatus? status,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Book &&
        other.id == id &&
        other.title == title &&
        other.author == author &&
        other.status == status;
  }

  @override
  int get hashCode => Object.hash(id, title, author, status);
}
