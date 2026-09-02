import 'dart:convert';
import 'dart:typed_data';

import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/core/network/dio/dio_api_client.dart';
import 'package:advanced_concepts/core/network/dio/dio_app_exception_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _ScriptAdapter implements HttpClientAdapter {
  _ScriptAdapter(this._handler);

  final Future<ResponseBody> Function(RequestOptions options) _handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return _handler(options);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  DioApiClient clientWith(
    Future<ResponseBody> Function(RequestOptions options) handler, {
    Duration timeout = const Duration(milliseconds: 20),
  }) {
    final dio =
        Dio(
            BaseOptions(
              baseUrl: 'http://api.test/',
              connectTimeout: timeout,
              receiveTimeout: timeout,
              sendTimeout: timeout,
            ),
          )
          ..httpClientAdapter = _ScriptAdapter(handler)
          ..interceptors.add(const DioAppExceptionInterceptor());
    return DioApiClient(dio);
  }

  ResponseBody jsonBody(Object json, int status) {
    return ResponseBody.fromString(
      jsonEncode(json),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  test('2xx returns parsed JSON from a Dio response', () async {
    final client = clientWith((options) async {
      expect(options.method, 'GET');
      expect(options.path, '/x');
      return jsonBody({'ok': true}, 200);
    });
    final json = await client.get('/x', (body) => body! as Map);
    expect(json['ok'], true);
  });

  test('401, 404, 500, and other statuses become AppException', () async {
    Future<void> expectStatus(int status, Matcher matcher) async {
      final client = clientWith((options) async {
        return jsonBody({}, status);
      });
      expect(client.get('/x', (_) {}), throwsA(matcher));
    }

    await expectStatus(401, isA<UnauthorizedException>());
    await expectStatus(404, isA<NotFoundException>());
    await expectStatus(500, isA<ServerException>());
    await expectStatus(409, isA<NetworkException>());
  });

  test('slow HTTP becomes RequestTimeoutException', () async {
    final client = clientWith((options) async {
      await Future<void>.delayed(const Duration(milliseconds: 80));
      return jsonBody({}, 200);
    });
    expect(
      client.get('/timeout', (_) {}),
      throwsA(isA<RequestTimeoutException>()),
    );
  });

  test('connection failure becomes NetworkException', () async {
    final client = clientWith((options) async {
      throw DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
      );
    });
    expect(client.get('/offline', (_) {}), throwsA(isA<NetworkException>()));
  });
}
