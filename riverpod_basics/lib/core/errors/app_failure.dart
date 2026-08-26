import 'package:riverpod_basics/core/errors/app_exception.dart';

/// Thrown by repositories after mapping. What state and AsyncError hold.
/// No user-facing strings.
sealed class AppFailure implements Exception {
  const AppFailure();

  /// Same idea as ApiFailure.fromException — typed, not a catch-all Object.
  factory AppFailure.fromException(AppException exception) {
    return switch (exception) {
      NetworkException() || FakePageEnterException() => const NetworkFailure(),
      NotFoundException() => const NotFoundFailure(),
    };
  }
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure();
}

final class NotFoundFailure extends AppFailure {
  const NotFoundFailure();
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure();
}
