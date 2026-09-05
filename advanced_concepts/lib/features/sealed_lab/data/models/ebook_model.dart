part of 'book_format_model.dart';

class EbookModel extends BookFormatModel {
  const EbookModel({
    required super.title,
    required super.author,
    required this.megabytes,
  });

  factory EbookModel.fromJson(Map<String, dynamic> json) {
    return EbookModel(
      title: _readString(json, 'title'),
      author: _readString(json, 'author'),
      megabytes: _readInt(json, 'megabytes'),
    );
  }

  final int megabytes;

  @override
  BookMetadata toEntity() {
    return Ebook(title: title, author: author, megabytes: megabytes);
  }
}
