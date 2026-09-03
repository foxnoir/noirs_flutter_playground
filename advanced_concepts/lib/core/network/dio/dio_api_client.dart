import 'dart:async';

import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/core/network/dio/dio_app_exception_interceptor.dart';
import 'package:advanced_concepts/core/network/dio/dio_auth_interceptor.dart';
import 'package:advanced_concepts/core/network/dio/dio_log_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Dio twin of the http ApiClient: timeouts, status codes, connection errors.
/// Interceptors log (debug) and map failures. Data sources only parse JSON.
class DioApiClient {
  DioApiClient(this._dio);

  factory DioApiClient.create({
    required Uri baseUrl,
    Duration timeout = const Duration(seconds: 5),
    bool log = kDebugMode,
    String? Function()? readAccessToken,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl.toString(),
        connectTimeout: timeout,
        receiveTimeout: timeout,
        sendTimeout: timeout,
        headers: const {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=utf-8',
        },
      ),
    );
    dio.interceptors.add(DioAuthInterceptor(readAccessToken ?? () => null));
    dio.interceptors.add(const DioAppExceptionInterceptor());
    if (log) {
      dio.interceptors.add(const DioLogInterceptor());
    }
    return DioApiClient(dio);
  }

  final Dio _dio;

  void close() => _dio.close();

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
    return _send('POST', path, parse, data: body, timeout: timeout);
  }

  Future<T> put<T>(
    String path,
    Map<String, Object?> body,
    T Function(Object? json) parse, {
    Duration? timeout,
  }) {
    return _send('PUT', path, parse, data: body, timeout: timeout);
  }

  Future<void> delete(String path, {Duration? timeout}) {
    return _send('DELETE', path, (_) {}, timeout: timeout);
  }

  Future<T> _send<T>(
    String method,
    String path,
    T Function(Object? json) parse, {
    Object? data,
    Duration? timeout,
    Uri? uri,
  }) async {
    final options = Options(
      method: method,
      sendTimeout: timeout,
      receiveTimeout: timeout,
    );
    try {
      final request = uri == null
          ? _dio.request<dynamic>(path, data: data, options: options)
          : _dio.requestUri<dynamic>(uri, data: data, options: options);
      final deadline =
          timeout ?? _dio.options.receiveTimeout ?? const Duration(seconds: 5);
      final response = await request.timeout(deadline);
      return parse(response.data);
    } on AppException {
      rethrow;
    } on TimeoutException {
      throw const RequestTimeoutException();
    } on DioException catch (e) {
      final cause = e.error;
      if (cause is AppException) {
        throw cause;
      }
      throw const NetworkException();
    } catch (_) {
      throw const NetworkException();
    }
  }
}
