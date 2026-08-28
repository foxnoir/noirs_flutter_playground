import 'package:riverpod_basics/features/labs/quote/domain/entities/quote.dart';

/// Throws AppFailure when the data source failed. No user-facing strings.
abstract interface class QuoteRepository {
  Future<Quote> fetchQuote();

  /// Next GET fails. Lab-only; the flag lives on the data source.
  void failCall();
}
