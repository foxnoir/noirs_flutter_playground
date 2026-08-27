import 'package:riverpod_basics/core/errors/app_exception.dart';
import 'package:riverpod_basics/features/labs/quote/data/data_sources/in_memory_quote_data_source.dart';
import 'package:riverpod_basics/features/labs/quote/data/models/quote_model.dart';

class FakeQuoteDataSource implements QuoteDataSource {
  FakeQuoteDataSource({this.model, this.error});

  final QuoteModel? model;
  final AppException? error;

  @override
  Future<QuoteModel> fetchQuote() async {
    final thrown = error;
    if (thrown != null) {
      throw thrown;
    }
    return model ?? const QuoteModel(text: 'From source', author: 'Fake');
  }
}
