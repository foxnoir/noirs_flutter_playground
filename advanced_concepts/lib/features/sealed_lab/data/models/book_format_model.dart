import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/features/sealed_lab/domain/entities/book_metadata.dart';

part 'hardcover_model.dart';
part 'paperback_model.dart';
part 'ebook_model.dart';

/// JSON shape of one format. `format` is the discriminator.
sealed class BookFormatModel {
  const BookFormatModel({required this.title, required this.author});

  factory BookFormatModel.fromJson(Map<String, dynamic> json) {
    final format = json['format'];
    if (format is! String) {
      throw const NetworkException();
    }
    return switch (format) {
      'hardcover' => HardcoverModel.fromJson(json),
      'paperback' => PaperbackModel.fromJson(json),
      'ebook' => EbookModel.fromJson(json),
      _ => throw const NetworkException(),
    };
  }

  final String title;
  final String author;

  BookMetadata toEntity();
}

String _readString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is! String) {
    throw const NetworkException();
  }
  return value;
}

int _readInt(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is! int) {
    throw const NetworkException();
  }
  return value;
}

bool _readBool(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is! bool) {
    throw const NetworkException();
  }
  return value;
}
