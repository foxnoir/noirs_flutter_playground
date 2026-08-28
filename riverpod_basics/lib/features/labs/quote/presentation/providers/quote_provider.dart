import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/quote/data/repositories/in_memory_quote_repository.dart';
import 'package:riverpod_basics/features/labs/quote/domain/entities/quote.dart';

/// Fake GET latency. Tests override this to [Duration.zero].
final quoteDelayProvider = Provider<Duration>((ref) {
  return const Duration(milliseconds: 400);
});

Future<Quote> _fetchQuote(Ref ref) async {
  final repository = ref.watch(quoteRepositoryProvider);
  final delay = ref.watch(quoteDelayProvider);
  if (delay > Duration.zero) {
    await Future<void>.delayed(delay);
  }
  return repository.fetchQuote();
}

/// No extra input. Reload is invalidate (or refresh).
/// `retry: null` matches codegen labs. Riverpod 3 otherwise retries a
/// failed GET (200ms+), which would hide **Fail call**.
final quoteProvider = FutureProvider<Quote>(_fetchQuote, retry: (_, _) => null);

/// Number that [quoteFromInputProvider] watches. Incrementing it re-runs
/// that GET without invalidate. [quoteProvider] does not watch this.
final quoteNumberProvider = NotifierProvider<QuoteNumberNotifier, int>(
  QuoteNumberNotifier.new,
);

class QuoteNumberNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void incrementQuoteNumber() => state++;
}

/// Same GET as [quoteProvider], but it watches [quoteNumberProvider].
final quoteFromInputProvider = FutureProvider<Quote>((ref) {
  ref.watch(quoteNumberProvider);
  return _fetchQuote(ref);
}, retry: (_, _) => null);

/// [quoteProvider] has no methods. The screen calls [QuoteFailCallNotifier.failCall];
/// this notifier talks to the repository and invalidates the GET.
final quoteFailCallProvider = NotifierProvider<QuoteFailCallNotifier, bool>(
  QuoteFailCallNotifier.new,
);

class QuoteFailCallNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void failCall() {
    ref.read(quoteRepositoryProvider).failCall();
    ref.invalidate(quoteProvider);
  }
}
