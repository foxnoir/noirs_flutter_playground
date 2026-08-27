import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/quote/data/data_sources/in_memory_quote_data_source.dart';
import 'package:riverpod_basics/features/labs/quote/data/repositories/in_memory_quote_repository.dart';
import 'package:riverpod_basics/features/labs/quote/domain/entities/quote.dart';
import 'package:riverpod_basics/features/labs/quote/domain/repositories/quote_repository.dart';
import 'package:riverpod_basics/features/labs/quote/presentation/providers/quote_provider.dart';

import '../../fake_quote_repository.dart';

void main() {
  const quote = Quote(text: 'Hello', author: 'Ada');

  ProviderContainer containerWith({
    required QuoteRepository repository,
    Duration delay = Duration.zero,
  }) {
    final container = ProviderContainer.test(
      overrides: [
        quoteRepositoryProvider.overrideWithValue(repository),
        quoteDelayProvider.overrideWithValue(delay),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('loads the quote after the fake delay', () async {
    final container = containerWith(
      repository: const FakeQuoteRepository(quote: quote),
    )..listen(quoteProvider, (_, _) {});

    final loaded = await container.read(quoteProvider.future);

    expect(loaded.text, 'Hello');
    expect(loaded.author, 'Ada');
  });

  test('a repository failure is AsyncError with NetworkFailure', () async {
    final container = containerWith(
      repository: const FakeQuoteRepository(error: NetworkFailure()),
    );
    final sub = container.listen(quoteProvider, (_, _) {});

    await container.pump();

    expect(sub.read().error, isA<NetworkFailure>());
  });

  test(
    'failCall then the next GET is AsyncError with NetworkFailure',
    () async {
      final container = ProviderContainer.test(
        overrides: [quoteDelayProvider.overrideWithValue(Duration.zero)],
      );
      addTearDown(container.dispose);
      final sub = container.listen(quoteProvider, (_, _) {});

      await container.read(quoteProvider.future);

      container.read(quoteDataSourceProvider).failCall();

      await expectLater(
        container.refresh(quoteProvider.future),
        throwsA(isA<NetworkFailure>()),
      );

      expect(sub.read().error, isA<NetworkFailure>());
    },
  );

  test('incrementQuoteNumber re-runs only quoteFromInputProvider', () async {
    final repository = _CountingQuoteRepository();
    final container = containerWith(repository: repository)
      ..listen(quoteProvider, (_, _) {})
      ..listen(quoteFromInputProvider, (_, _) {});

    await container.read(quoteProvider.future);
    await container.read(quoteFromInputProvider.future);
    expect(repository.calls, 2);

    container.read(quoteNumberProvider.notifier).incrementQuoteNumber();
    await container.read(quoteFromInputProvider.future);

    expect(repository.calls, 3);
  });
}

class _CountingQuoteRepository implements QuoteRepository {
  int calls = 0;

  @override
  Future<Quote> fetchQuote() async {
    calls++;
    return const Quote(text: 'Hello', author: 'Ada');
  }
}
