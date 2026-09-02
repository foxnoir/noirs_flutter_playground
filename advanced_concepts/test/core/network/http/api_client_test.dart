import 'dart:convert';

import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/core/network/http/api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  ApiClient clientWith(MockClientHandler handler) {
    return ApiClient(
      client: MockClient(handler),
      baseUrl: Uri.parse('http://api.test/'),
      timeout: const Duration(milliseconds: 20),
    );
  }

  test('2xx returns parsed JSON from a real HTTP response', () async {
    final client = clientWith((request) async {
      expect(request.method, 'GET');
      expect(request.url.path, '/x');
      return http.Response(
        jsonEncode({'ok': true}),
        200,
        headers: {'content-type': 'application/json'},
      );
    });
    final json = await client.get('/x', (body) => body! as Map);
    expect(json['ok'], true);
  });

  test('401, 404, 500, and other statuses become AppException', () async {
    Future<void> expectStatus(int status, Matcher matcher) async {
      final client = clientWith((request) async {
        return http.Response('{}', status);
      });
      expect(client.get('/x', (_) {}), throwsA(matcher));
    }

    await expectStatus(401, isA<UnauthorizedException>());
    await expectStatus(404, isA<NotFoundException>());
    await expectStatus(500, isA<ServerException>());
    await expectStatus(409, isA<NetworkException>());
  });

  test('slow HTTP becomes RequestTimeoutException', () async {
    final client = clientWith((request) async {
      await Future<void>.delayed(const Duration(milliseconds: 80));
      return http.Response('{}', 200);
    });
    expect(
      client.get('/timeout', (_) {}),
      throwsA(isA<RequestTimeoutException>()),
    );
  });

  test('HTTP client exception becomes NetworkException', () async {
    final client = clientWith((request) async {
      throw http.ClientException('Failed host lookup', request.url);
    });
    expect(client.get('/offline', (_) {}), throwsA(isA<NetworkException>()));
  });
}
