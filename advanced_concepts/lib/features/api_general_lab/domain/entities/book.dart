import 'package:meta/meta.dart';

@immutable
class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.finished,
  });

  final String? id;
  final String title;
  final String author;
  final bool finished;

  @override
  bool operator ==(Object other) {
    return other is Book &&
        other.id == id &&
        other.title == title &&
        other.author == author &&
        other.finished == finished;
  }

  @override
  int get hashCode => Object.hash(id, title, author, finished);
}
