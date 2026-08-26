import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/errors/app_exception.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/core/errors/map_to_app_failure.dart';

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
      AppFailure.fromException(const FakePageEnterException(3)),
      const NetworkFailure(),
    );
  });

  test('maps network exceptions to NetworkFailure', () {
    expect(mapToAppFailure(const NetworkException()), const NetworkFailure());
    expect(
      mapToAppFailure(const FakePageEnterException(3)),
      const NetworkFailure(),
    );
  });

  test('maps not found to NotFoundFailure', () {
    expect(mapToAppFailure(const NotFoundException()), const NotFoundFailure());
  });

  test('maps unknown objects to UnknownFailure', () {
    expect(mapToAppFailure(Exception('nope')), const UnknownFailure());
  });

  test('passes AppFailure through', () {
    expect(mapToAppFailure(const NetworkFailure()), const NetworkFailure());
  });
}
