import 'package:advanced_concepts/features/api_integration_lab/domain/entities/book.dart';

class BookModel {
  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.finished,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    return BookModel(
      id: id?.toString(),
      title: json['title'] as String,
      author: json['author'] as String,
      finished: json['finished'] as bool? ?? false,
    );
  }

  final String? id;
  final String title;
  final String author;
  final bool finished;

  Book toEntity() {
    return Book(id: id, title: title, author: author, finished: finished);
  }
}
