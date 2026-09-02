import 'dart:async';
import 'dart:convert';

import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:http/http.dart' as http;

/// One place for timeout, status codes, and connection errors.
/// Data sources parse JSON. They do not read the HTTP status code.
class ApiClient {
  const ApiClient({
    required this.client,
    required this.baseUrl,
    this.timeout = const Duration(seconds: 5),
  });

  final http.Client client;
  final Uri baseUrl;
  final Duration timeout;

  Future<T> get<T>(
    String path,
    T Function(Object? json) parse, {
    Duration? timeout,
    Uri? uri,
  }) {
    return _send('GET', path, parse, timeout: timeout, uri: uri);
  }

  Future<T> post<T>(
    String path,
    Map<String, Object?> body,
    T Function(Object? json) parse, {
    Duration? timeout,
  }) {
    return _send('POST', path, parse, body: body, timeout: timeout);
  }

  Future<T> put<T>(
    String path,
    Map<String, Object?> body,
    T Function(Object? json) parse, {
    Duration? timeout,
  }) {
    return _send('PUT', path, parse, body: body, timeout: timeout);
  }

  Future<void> delete(String path, {Duration? timeout}) {
    return _send('DELETE', path, (_) {}, timeout: timeout);
  }

  Uri _uri(String path) {
    final relative = path.startsWith('/') ? path.substring(1) : path;
    return baseUrl.resolve(relative);
  }

  Future<T> _send<T>(
    String method,
    String path,
    T Function(Object? json) parse, {
    Map<String, Object?>? body,
    Duration? timeout,
    Uri? uri,
  }) async {
    final headers = <String, String>{'Accept': 'application/json'};
    final encoded = body == null ? null : jsonEncode(body);
    if (encoded != null) {
      headers['Content-Type'] = 'application/json; charset=utf-8';
    }
    final url = uri ?? _uri(path);

    try {
      final response = await _dispatch(
        method,
        url,
        headers,
        encoded,
      ).timeout(timeout ?? this.timeout);
      final decoded = _decode(response.body);
      return switch (response.statusCode) {
        >= 200 && < 300 => parse(decoded),
        401 => throw const UnauthorizedException(),
        404 => throw const NotFoundException(),
        >= 500 => throw const ServerException(),
        _ => throw const NetworkException(),
      };
    } on AppException {
      rethrow;
    } on TimeoutException {
      throw const RequestTimeoutException();
    } catch (_) {
      throw const NetworkException();
    }
  }

  Future<http.Response> _dispatch(
    String method,
    Uri url,
    Map<String, String> headers,
    String? encoded,
  ) {
    return switch (method) {
      'GET' => client.get(url, headers: headers),
      'POST' => client.post(url, headers: headers, body: encoded),
      'PUT' => client.put(url, headers: headers, body: encoded),
      'DELETE' => client.delete(url, headers: headers),
      _ => throw const NetworkException(),
    };
  }

  Object? _decode(String body) {
    if (body.isEmpty) {
      return null;
    }
    return jsonDecode(body);
  }
}
