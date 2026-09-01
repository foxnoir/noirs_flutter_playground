import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/core/network/api_client.dart';
import 'package:advanced_concepts/features/api_general_lab/data/models/book_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

abstract interface class BookApiDataSource {
  Future<BookModel> fetchSuccess();

  Future<void> fetchError();

  Future<BookModel> fetchTimeout({Duration? timeout});

  Future<void> fetchOffline();

  Future<List<BookModel>> fetchBooks();

  Future<BookModel> identify({required String title, required String author});
}

/// Firebase emulator by default. Override [apiBaseUrlProvider] after deploy.
final apiBaseUrlProvider = Provider<Uri>((ref) {
  return Uri.parse(
    'http://127.0.0.1:5001/noirs-firebase-lab/europe-west1/api/',
  );
});

final httpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    client: ref.watch(httpClientProvider),
    baseUrl: ref.watch(apiBaseUrlProvider),
  );
});

final bookApiDataSourceProvider = Provider<BookApiDataSource>((ref) {
  return HttpBookApiDataSource(ref.watch(apiClientProvider));
});

/// Closed port — a real TCP failure, not an HTTP status.
const offlineUri = 'http://127.0.0.1:1/offline';

/// Talks only to [ApiClient]. Throws AppException, never AppFailure.
class HttpBookApiDataSource implements BookApiDataSource {
  const HttpBookApiDataSource(this._client);

  final ApiClient _client;

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
      'finished': false,
    });
  }

  @override
  Future<void> fetchOffline() async {
    await _client.get('/offline', _asMap, uri: Uri.parse(offlineUri));
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
  Future<BookModel> identify({
    required String title,
    required String author,
  }) async {
    final json = await _client.post('/identify', {
      'title': title,
      'author': author,
    }, _asMap);
    return BookModel.fromJson(_asMap(json['book']));
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
