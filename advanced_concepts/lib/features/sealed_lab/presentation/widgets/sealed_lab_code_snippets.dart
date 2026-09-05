import 'package:advanced_concepts/features/sealed_lab/domain/entities/book_metadata.dart';

/// Exact Dart shown in the lab (not localized).
abstract final class SealedLabCodeSnippets {
  static const jsonSubclass =
      'class BookWithSeries extends BookModel {\n'
      '  BookWithSeries({required this.series, …})\n'
      '      : super(title: title, author: author);\n'
      '  final String series;\n'
      '}';

  static const bookMetadata =
      'sealed class BookMetadata {\n'
      '  const BookMetadata({\n'
      '    required this.title,\n'
      '    required this.author,\n'
      '  });\n'
      '  final String title;\n'
      '  final String author;\n'
      '}';

  static const hardcover =
      'class Hardcover extends BookMetadata {\n'
      '  const Hardcover({\n'
      '    required super.title,\n'
      '    required super.author,\n'
      '    required this.pages,\n'
      '  });\n'
      '  final int pages;\n'
      '}';

  static const paperback =
      'class Paperback extends BookMetadata {\n'
      '  const Paperback({\n'
      '    required super.title,\n'
      '    required super.author,\n'
      '    required this.massMarket,\n'
      '  });\n'
      '  final bool massMarket;\n'
      '}';

  static const ebook =
      'class Ebook extends BookMetadata {\n'
      '  const Ebook({\n'
      '    required super.title,\n'
      '    required super.author,\n'
      '    required this.megabytes,\n'
      '  });\n'
      '  final int megabytes;\n'
      '}';

  static const hardcoverSwitch =
      'switch (format) {\n'
      '  Hardcover(:final pages) => …,\n'
      '}';

  static const paperbackSwitch =
      'switch (format) {\n'
      '  Paperback(:final massMarket) => …,\n'
      '}';

  static const ebookSwitch =
      'switch (format) {\n'
      '  Ebook(:final megabytes) => …,\n'
      '}';

  static String subclass(BookMetadata format) {
    return switch (format) {
      Hardcover() => hardcover,
      Paperback() => paperback,
      Ebook() => ebook,
    };
  }

  static String formatSwitch(BookMetadata format) {
    return switch (format) {
      Hardcover() => hardcoverSwitch,
      Paperback() => paperbackSwitch,
      Ebook() => ebookSwitch,
    };
  }
}
