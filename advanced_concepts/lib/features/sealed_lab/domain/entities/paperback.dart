part of 'book_metadata.dart';

class Paperback extends BookMetadata {
  const Paperback({
    required super.title,
    required super.author,
    required this.massMarket,
  });

  final bool massMarket;

  @override
  bool operator ==(Object other) {
    return other is Paperback &&
        other.title == title &&
        other.author == author &&
        other.massMarket == massMarket;
  }

  @override
  int get hashCode => Object.hash(title, author, massMarket);
}
