import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/errors/app_exception.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/quote/data/models/quote_model.dart';
import 'package:riverpod_basics/features/labs/quote/data/repositories/in_memory_quote_repository.dart';

import '../../fake_quote_data_source.dart';

void main() {
  test('maps a model to a Quote entity', () async {
    final repository = InMemoryQuoteRepository(
      FakeQuoteDataSource(
        model: const QuoteModel(text: 'Hello', author: 'Ada'),
      ),
    );

    final quote = await repository.fetchQuote();

    expect(quote.text, 'Hello');
    expect(quote.author, 'Ada');
  });

  test('maps NetworkException to NetworkFailure', () async {
    final repository = InMemoryQuoteRepository(
      FakeQuoteDataSource(error: const NetworkException()),
    );

    await expectLater(repository.fetchQuote(), throwsA(isA<NetworkFailure>()));
  });
}
