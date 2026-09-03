import 'package:dio/dio.dart';

/// Adds `Authorization` when a lab token is present.
/// Mapping stays on `DioAppExceptionInterceptor`. Logging stays on
/// `DioLogInterceptor`. package:http has no interceptors — it sets the
/// header in `_send`.
class DioAuthInterceptor extends Interceptor {
  const DioAuthInterceptor(this.readAccessToken);

  final String? Function() readAccessToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
