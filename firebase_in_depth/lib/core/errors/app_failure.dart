import 'package:firebase_in_depth/core/errors/app_exception.dart';
import 'package:meta/meta.dart';

/// Thrown by repositories after mapping. What state and AsyncError hold.
/// No user-facing strings.
@immutable
sealed class AppFailure implements Exception {
  const AppFailure();

  /// Same idea as ApiFailure.fromException — typed, not a catch-all Object.
  factory AppFailure.fromException(AppException exception) {
    return switch (exception) {
      NetworkException() => const NetworkFailure(),
      NotFoundException() => const NotFoundFailure(),
      PermissionException() => const PermissionFailure(),
      AuthException() => const AuthFailure(),
      InvalidQueryException(:final detail) => InvalidQueryFailure(
        detail: detail,
      ),
    };
  }

  /// For UI / demo notifiers that have no repository.
  /// Repositories use [AppFailure.fromException] on [AppException] only.
  factory AppFailure.from(Object error) {
    return switch (error) {
      AppFailure() => error,
      AppException() => AppFailure.fromException(error),
      _ => const UnknownFailure(),
    };
  }
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure();
}

final class NotFoundFailure extends AppFailure {
  const NotFoundFailure();
}

final class PermissionFailure extends AppFailure {
  const PermissionFailure();
}

final class AuthFailure extends AppFailure {
  const AuthFailure();
}

final class InvalidQueryFailure extends AppFailure {
  const InvalidQueryFailure({this.detail});

  final String? detail;

  @override
  bool operator ==(Object other) {
    return other is InvalidQueryFailure && other.detail == detail;
  }

  @override
  int get hashCode => detail.hashCode;
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure();
}
