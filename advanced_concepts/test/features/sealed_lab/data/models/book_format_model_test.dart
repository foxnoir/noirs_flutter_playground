import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/features/sealed_lab/data/models/book_format_model.dart';
import 'package:advanced_concepts/features/sealed_lab/domain/entities/book_metadata.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('hardcover JSON maps to Hardcover', () {
    final entity = BookFormatModel.fromJson({
      'format': 'hardcover',
      'title': 'Fourth Wing',
      'author': 'Rebecca Yarros',
      'pages': 512,
    }).toEntity();

    expect(
      entity,
      const Hardcover(
        title: 'Fourth Wing',
        author: 'Rebecca Yarros',
        pages: 512,
      ),
    );
  });

  test('paperback JSON maps to Paperback', () {
    final entity = BookFormatModel.fromJson({
      'format': 'paperback',
      'title': 'Fourth Wing',
      'author': 'Rebecca Yarros',
      'massMarket': false,
    }).toEntity();

    expect(
      entity,
      const Paperback(
        title: 'Fourth Wing',
        author: 'Rebecca Yarros',
        massMarket: false,
      ),
    );
  });

  test('ebook JSON maps to Ebook', () {
    final entity = BookFormatModel.fromJson({
      'format': 'ebook',
      'title': 'Fourth Wing',
      'author': 'Rebecca Yarros',
      'megabytes': 3,
    }).toEntity();

    expect(
      entity,
      const Ebook(title: 'Fourth Wing', author: 'Rebecca Yarros', megabytes: 3),
    );
  });

  test('unknown format throws NetworkException', () {
    expect(
      () => BookFormatModel.fromJson({
        'format': 'audiobook',
        'title': 'Fourth Wing',
        'author': 'Rebecca Yarros',
      }),
      throwsA(isA<NetworkException>()),
    );
  });
}
