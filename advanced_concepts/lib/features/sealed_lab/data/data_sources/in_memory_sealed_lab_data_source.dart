import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/features/sealed_lab/data/models/book_format_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: one_member_abstracts — one GET; tests swap the fake
abstract interface class SealedLabDataSource {
  Future<List<BookFormatModel>> fetchFormats();
}

final sealedLabDataSourceProvider = Provider<SealedLabDataSource>((ref) {
  return const InMemorySealedLabDataSource();
});

/// Fake GET. Throws AppException, never AppFailure.
class InMemorySealedLabDataSource implements SealedLabDataSource {
  const InMemorySealedLabDataSource({this.delay = Duration.zero});

  final Duration delay;

  /// Same payload a books API would send: `format` picks the subclass.
  static const seedJson = [
    {
      'format': 'hardcover',
      'title': 'Fourth Wing',
      'author': 'Rebecca Yarros',
      'pages': 512,
    },
    {
      'format': 'paperback',
      'title': 'Fourth Wing',
      'author': 'Rebecca Yarros',
      'massMarket': false,
    },
    {
      'format': 'ebook',
      'title': 'Fourth Wing',
      'author': 'Rebecca Yarros',
      'megabytes': 3,
    },
  ];

  @override
  Future<List<BookFormatModel>> fetchFormats() async {
    try {
      if (delay > Duration.zero) {
        await Future<void>.delayed(delay);
      }
      return [
        for (final json in seedJson)
          BookFormatModel.fromJson(Map<String, dynamic>.from(json)),
      ];
    } on AppException {
      rethrow;
    } catch (_) {
      throw const NetworkException();
    }
  }
}
