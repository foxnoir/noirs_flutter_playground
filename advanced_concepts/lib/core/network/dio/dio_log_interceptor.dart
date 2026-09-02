import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Debug-only request/response/error log. No secrets, no production dump.
class DioLogInterceptor extends Interceptor {
  const DioLogInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint(
      'RESPONSE ${response.statusCode} ${response.requestOptions.uri}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('ERROR ${err.type} ${err.requestOptions.uri}');
    handler.next(err);
  }
}
