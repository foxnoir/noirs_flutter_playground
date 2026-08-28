import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/quote/domain/entities/quote.dart';
import 'package:riverpod_basics/features/labs/quote/domain/repositories/quote_repository.dart';

/// Repository fake: already past the data-source boundary, so it throws
/// AppFailure, not AppException.
class FakeQuoteRepository implements QuoteRepository {
  const FakeQuoteRepository({this.quote, this.error});

  final Quote? quote;
  final AppFailure? error;

  @override
  Future<Quote> fetchQuote() async {
    final thrown = error;
    if (thrown != null) {
      throw thrown;
    }
    return quote ?? const Quote(text: 'Fake quote', author: 'Test');
  }

  @override
  void failCall() {}
}
