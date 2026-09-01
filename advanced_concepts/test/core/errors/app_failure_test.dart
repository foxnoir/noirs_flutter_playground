import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/core/errors/app_failure.dart';
import 'package:flutter_test/flutter_test.dart';

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
    expect(
      AppFailure.fromException(const RequestTimeoutException()),
      const TimeoutFailure(),
    );
    expect(
      AppFailure.fromException(const UnauthorizedException()),
      const UnauthorizedFailure(),
    );
    expect(
      AppFailure.fromException(const ServerException()),
      const ServerFailure(),
    );
  });

  test('from maps exceptions, failures, and unknown objects', () {
    expect(AppFailure.from(const NetworkException()), const NetworkFailure());
    expect(AppFailure.from(const NotFoundException()), const NotFoundFailure());
    expect(AppFailure.from(const NetworkFailure()), const NetworkFailure());
    expect(AppFailure.from(Exception('nope')), const UnknownFailure());
  });
}
