import 'package:advanced_concepts/features/api_http_lab/domain/entities/book.dart';

class BookModel {
  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.status,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    return BookModel(
      id: id?.toString(),
      title: json['title'] as String,
      author: json['author'] as String,
      status: parseBookStatus(json),
    );
  }

  final String? id;
  final String title;
  final String author;
  final BookStatus status;

  Book toEntity() {
    return Book(id: id, title: title, author: author, status: status);
  }
}

BookStatus parseBookStatus(Map<String, dynamic> json) {
  final status = json['status'];
  if (status is String) {
    return switch (status) {
      'finished' => BookStatus.finished,
      'not_started' => BookStatus.notStarted,
      _ => BookStatus.reading,
    };
  }
  return json['finished'] == true ? BookStatus.finished : BookStatus.reading;
}
