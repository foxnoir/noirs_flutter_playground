/// Exact Dart shown in the lab (not localized).
abstract final class SealedLabCodeSnippets {
  static const jsonSubclass =
      'class BookWithSeries extends BookModel {\n'
      '  BookWithSeries({required this.series, …})\n'
      '      : super(title: title, author: author);\n'
      '  final String series;\n'
      '}';

  static const sealedFamily =
      'sealed class BookFormat {\n'
      '  const BookFormat({required this.title, required this.author});\n'
      '  final String title;\n'
      '  final String author;\n'
      '}\n'
      '\n'
      'class Hardcover extends BookFormat {\n'
      '  const Hardcover({\n'
      '    required super.title,\n'
      '    required super.author,\n'
      '    required this.pages,\n'
      '  });\n'
      '  final int pages;\n'
      '}';

  static const formatSwitch =
      'switch (book) {\n'
      '  Hardcover(:final pages) => …,\n'
      '  Paperback(:final massMarket) => …,\n'
      '  Ebook(:final megabytes) => …,\n'
      '}';
}
