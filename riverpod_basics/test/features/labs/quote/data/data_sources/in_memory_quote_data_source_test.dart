import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/errors/app_exception.dart';
import 'package:riverpod_basics/features/labs/quote/data/data_sources/in_memory_quote_data_source.dart';
import 'package:riverpod_basics/features/labs/quote/data/models/quote_model.dart';

void main() {
  bool isKnown(QuoteModel model) {
    return InMemoryQuoteDataSource.quotes.any(
      (quote) => quote.text == model.text && quote.author == model.author,
    );
  }

  test('returns a quote from the list', () async {
    final source = InMemoryQuoteDataSource(random: Random(42));

    final model = await source.fetchQuote();

    expect(isKnown(model), isTrue);
  });

  test('a second GET is a different quote', () async {
    final source = InMemoryQuoteDataSource(random: Random(42));

    final first = await source.fetchQuote();
    final second = await source.fetchQuote();

    expect(isKnown(second), isTrue);
    expect(second.text, isNot(first.text));
  });

  test('failCall throws NetworkException once', () async {
    final source = InMemoryQuoteDataSource(random: Random(42))..failCall();

    await expectLater(source.fetchQuote(), throwsA(isA<NetworkException>()));

    final model = await source.fetchQuote();
    expect(isKnown(model), isTrue);
  });
}
