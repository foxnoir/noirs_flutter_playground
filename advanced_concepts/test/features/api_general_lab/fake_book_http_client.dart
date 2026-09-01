import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

/// In-memory HTTP stand-in for widget/unit tests. The running app talks to
/// Firebase over the real [http.Client].
http.Client fakeBookHttpClient({
  Duration slowDelay = const Duration(milliseconds: 80),
}) {
  final books = [for (final json in _seed) Map<String, Object?>.from(json)];

  return MockClient((request) async {
    if (request.url.port == 1 || request.url.path.endsWith('/offline')) {
      throw http.ClientException('Failed host lookup', request.url);
    }

    final path = request.url.path;
    final method = request.method;
    Map<String, Object?>? body;
    if (request.body.isNotEmpty) {
      body = Map<String, Object?>.from(jsonDecode(request.body) as Map);
    }

    if (path.endsWith('/timeout') && method == 'GET') {
      await Future<void>.delayed(slowDelay);
      return _json({'message': 'Delayed response'}, 200);
    }
    if (path.endsWith('/error') && method == 'GET') {
      return _json({
        'code': 'unknown',
        'message': 'Internal server error occurred',
      }, 500);
    }
    if (path.endsWith('/success') && method == 'GET') {
      return _json({
        'message': 'Success response from server',
        'data': {
          'id': null,
          'title': 'A Court of Silver Flames',
          'author': 'Sarah J. Maas',
          'finished': false,
        },
      }, 200);
    }
    if (path.endsWith('/identify') && method == 'POST') {
      final title = body?['title'];
      final author = body?['author'];
      for (final book in books) {
        if (book['title'] == title && book['author'] == author) {
          return _json({'message': 'Match found', 'book': book}, 200);
        }
      }
      return _json({
        'code': 'unauthorized',
        'message': 'Invalid title or author',
      }, 401);
    }
    if (path.endsWith('/books') && method == 'GET') {
      return _json({'message': 'Books fetched', 'books': books}, 200);
    }

    return _json({'code': 'not_found', 'message': 'Not found'}, 404);
  });
}

http.Response _json(Object body, int status) {
  return http.Response(
    jsonEncode(body),
    status,
    headers: {'content-type': 'application/json'},
  );
}

const _seed = [
  {
    'id': '1',
    'title': 'A Court of Thorns and Roses',
    'author': 'Sarah J. Maas',
    'finished': true,
  },
  {
    'id': '3',
    'title': 'Fourth Wing',
    'author': 'Rebecca Yarros',
    'finished': true,
  },
];
