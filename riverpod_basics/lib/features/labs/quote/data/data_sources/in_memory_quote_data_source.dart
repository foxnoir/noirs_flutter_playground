import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/errors/app_exception.dart';
import 'package:riverpod_basics/features/labs/quote/data/models/quote_model.dart';

// ignore: one_member_abstracts -- contract; fail call is on the impl
abstract interface class QuoteDataSource {
  Future<QuoteModel> fetchQuote();
}

final quoteDataSourceProvider = Provider<InMemoryQuoteDataSource>((ref) {
  return InMemoryQuoteDataSource();
});

/// Fake GET /quote. Throws AppException, never AppFailure.
class InMemoryQuoteDataSource implements QuoteDataSource {
  InMemoryQuoteDataSource({Random? random}) : _random = random ?? Random();

  final Random _random;
  var _failCall = false;
  QuoteModel? _last;

  static const quotes = [
    QuoteModel(
      text: "I knew who I was this morning, but I've changed a few times since then.",
      author: 'Lewis Carroll',
    ),
    QuoteModel(
      text: '"You\'re not the same as you were before," he said. "You were much more... muchier... you\'ve lost your muchness."',
      author: 'Lewis Carroll',
    ),
    QuoteModel(text: 'Curiouser and curiouser!', author: 'Lewis Carroll'),
  ];

  /// Next [fetchQuote] throws [NetworkException], then clears.
  void failCall() => _failCall = true;

  QuoteModel _nextQuote() {
    final pool = [
      for (final quote in quotes)
        if (quote != _last) quote,
    ];
    final picked = pool[_random.nextInt(pool.length)];
    _last = picked;
    return picked;
  }

  @override
  Future<QuoteModel> fetchQuote() async {
    try {
      if (_failCall) {
        _failCall = false;
        throw const NetworkException();
      }
      return _nextQuote();
    } on AppException {
      rethrow;
    } catch (_) {
      throw const NetworkException();
    }
  }
}
