import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/core/network/api_access_token.dart';
import 'package:advanced_concepts/core/network/api_config.dart';
import 'package:advanced_concepts/core/network/dio/dio_api_client.dart';
import 'package:advanced_concepts/features/api_dio_lab/data/models/book_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class ApiDioLabDataSource {
  Future<BookModel> fetchSuccess();

  Future<void> fetchError();

  Future<BookModel> fetchTimeout({Duration? timeout});

  Future<void> fetchOffline();

  Future<List<BookModel>> fetchBooks();

  Future<BookModel> search({required String title, required String author});

  Future<BookModel> addBook(BookModel book);

  Future<BookModel> updateBook(BookModel book);

  Future<void> deleteBook(String id);
}

final dioApiClientProvider = Provider<DioApiClient>((ref) {
  final token = ref.read(apiAccessTokenProvider);
  final client = DioApiClient.create(
    baseUrl: ref.watch(apiBaseUrlProvider),
    readAccessToken: () => token.value,
  );
  ref.onDispose(client.close);
  return client;
});

final apiDioLabDataSourceProvider = Provider<ApiDioLabDataSource>((ref) {
  return DioApiDioLabDataSource(ref.watch(dioApiClientProvider));
});

/// Talks only to [DioApiClient]. Throws AppException, never AppFailure.
class DioApiDioLabDataSource implements ApiDioLabDataSource {
  const DioApiDioLabDataSource(this._client);

  final DioApiClient _client;

  @override
  Future<BookModel> fetchSuccess() async {
    final json = await _client.get('/success', _asMap);
    return BookModel.fromJson(_asMap(json['data']));
  }

  @override
  Future<void> fetchError() async {
    await _client.get('/error', _asMap);
  }

  @override
  Future<BookModel> fetchTimeout({Duration? timeout}) async {
    final json = await _client.get('/timeout', _asMap, timeout: timeout);
    return BookModel.fromJson({
      'id': null,
      'title': json['message'] as String? ?? '',
      'author': '',
      'status': 'not_started',
    });
  }

  @override
  Future<void> fetchOffline() async {
    await _client.get('/offline', _asMap, uri: ApiConfig.offlineUri);
  }

  @override
  Future<List<BookModel>> fetchBooks() async {
    final json = await _client.get('/books', _asMap);
    final books = json['books'];
    if (books is! List) {
      throw const NetworkException();
    }
    return [for (final entry in books) BookModel.fromJson(_asMap(entry))];
  }

  @override
  Future<BookModel> search({
    required String title,
    required String author,
  }) async {
    final json = await _client.post('/search', {
      'title': title,
      'author': author,
    }, _asMap);
    return BookModel.fromJson(_asMap(json['book']));
  }

  @override
  Future<BookModel> addBook(BookModel book) async {
    final json = await _client.post('/books', book.toJson(), _asMap);
    return BookModel.fromJson(_asMap(json['book']));
  }

  @override
  Future<BookModel> updateBook(BookModel book) async {
    final id = book.id;
    if (id == null || id.isEmpty) {
      throw const NetworkException();
    }
    final json = await _client.put('/books/$id', book.toJson(), _asMap);
    return BookModel.fromJson(_asMap(json['book']));
  }

  @override
  Future<void> deleteBook(String id) {
    return _client.delete('/books/$id');
  }

  static Map<String, dynamic> _asMap(Object? json) {
    if (json is Map<String, dynamic>) {
      return json;
    }
    if (json is Map) {
      return Map<String, dynamic>.from(json);
    }
    throw const NetworkException();
  }
}
