import 'package:riverpod_basics/features/labs/quote/domain/entities/quote.dart';

/// Throws AppFailure when the data source failed. No user-facing strings.
// ignore: one_member_abstracts -- lab GET; no writes
abstract interface class QuoteRepository {
  Future<Quote> fetchQuote();
}
