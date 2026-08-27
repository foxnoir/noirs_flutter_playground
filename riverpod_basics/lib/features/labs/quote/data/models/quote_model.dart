import 'package:riverpod_basics/features/labs/quote/domain/entities/quote.dart';

/// In-memory DTO. No JSON — the GET is fake.
class QuoteModel {
  const QuoteModel({required this.text, required this.author});

  final String text;
  final String author;

  Quote toEntity() => Quote(text: text, author: author);
}
