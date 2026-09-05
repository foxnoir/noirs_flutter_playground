part of 'book_format_model.dart';

class HardcoverModel extends BookFormatModel {
  const HardcoverModel({
    required super.title,
    required super.author,
    required this.pages,
  });

  factory HardcoverModel.fromJson(Map<String, dynamic> json) {
    return HardcoverModel(
      title: _readString(json, 'title'),
      author: _readString(json, 'author'),
      pages: _readInt(json, 'pages'),
    );
  }

  final int pages;

  @override
  BookMetadata toEntity() {
    return Hardcover(title: title, author: author, pages: pages);
  }
}
