import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:dio/dio.dart';

/// Maps Dio failures to [AppException]. Data sources never read status codes.
class DioAppExceptionInterceptor extends Interceptor {
  const DioAppExceptionInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.error is AppException) {
      handler.next(err);
      return;
    }
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: _map(err),
        message: err.message,
      ),
    );
  }

  AppException _map(DioException err) {
    return switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.transformTimeout => const RequestTimeoutException(),
      DioExceptionType.badResponse => _fromStatus(err.response?.statusCode),
      DioExceptionType.badCertificate ||
      DioExceptionType.cancel ||
      DioExceptionType.connectionError ||
      DioExceptionType.unknown => const NetworkException(),
    };
  }

  AppException _fromStatus(int? statusCode) {
    if (statusCode == 401) {
      return const UnauthorizedException();
    }
    if (statusCode == 404) {
      return const NotFoundException();
    }
    if (statusCode != null && statusCode >= 500 && statusCode < 600) {
      return const ServerException();
    }
    return const NetworkException();
  }
}
