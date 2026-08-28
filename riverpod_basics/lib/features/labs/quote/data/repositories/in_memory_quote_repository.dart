import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/errors/app_exception.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/quote/data/data_sources/in_memory_quote_data_source.dart';
import 'package:riverpod_basics/features/labs/quote/domain/entities/quote.dart';
import 'package:riverpod_basics/features/labs/quote/domain/repositories/quote_repository.dart';

final quoteRepositoryProvider = Provider<QuoteRepository>((ref) {
  return InMemoryQuoteRepository(ref.watch(quoteDataSourceProvider));
});

/// Maps models → entities and AppException → AppFailure.
class InMemoryQuoteRepository implements QuoteRepository {
  const InMemoryQuoteRepository(this._dataSource);

  final QuoteDataSource _dataSource;

  @override
  Future<Quote> fetchQuote() async {
    try {
      final model = await _dataSource.fetchQuote();
      return model.toEntity();
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  @override
  void failCall() => _dataSource.failCall();
}
