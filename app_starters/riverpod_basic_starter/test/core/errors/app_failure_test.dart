import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basic_starter/core/errors/app_exception.dart';
import 'package:riverpod_basic_starter/core/errors/app_failure.dart';

void main() {
  test('fromException maps AppException to AppFailure', () {
    expect(
      AppFailure.fromException(const NetworkException()),
      const NetworkFailure(),
    );
    expect(
      AppFailure.fromException(const NotFoundException()),
      const NotFoundFailure(),
    );
  });

  test('from maps exceptions, failures, and unknown objects', () {
    expect(AppFailure.from(const NetworkException()), const NetworkFailure());
    expect(AppFailure.from(const NotFoundException()), const NotFoundFailure());
    expect(AppFailure.from(const NetworkFailure()), const NetworkFailure());
    expect(AppFailure.from(Exception('nope')), const UnknownFailure());
  });
}
