part of 'book_format_model.dart';

class PaperbackModel extends BookFormatModel {
  const PaperbackModel({
    required super.title,
    required super.author,
    required this.massMarket,
  });

  factory PaperbackModel.fromJson(Map<String, dynamic> json) {
    return PaperbackModel(
      title: _readString(json, 'title'),
      author: _readString(json, 'author'),
      massMarket: _readBool(json, 'massMarket'),
    );
  }

  final bool massMarket;

  @override
  BookMetadata toEntity() {
    return Paperback(title: title, author: author, massMarket: massMarket);
  }
}
