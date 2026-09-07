import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';

/// Thrown by data sources. The repository maps this to AppFailure.
@immutable
sealed class AppException implements Exception {
  const AppException();

  factory AppException.fromFirebase(FirebaseException exception) {
    return switch (exception.code) {
      'not-found' => const NotFoundException(),
      'permission-denied' => const PermissionException(),
      'invalid-argument' ||
      'failed-precondition' => InvalidQueryException(exception.message),
      _ => const NetworkException(),
    };
  }
}

final class NetworkException extends AppException {
  const NetworkException();
}

final class NotFoundException extends AppException {
  const NotFoundException();
}

final class PermissionException extends AppException {
  const PermissionException();
}

/// Firestore refused the query (two inequalities, missing index, …).
final class InvalidQueryException extends AppException {
  const InvalidQueryException([this.detail]);

  final String? detail;

  @override
  bool operator ==(Object other) {
    return other is InvalidQueryException && other.detail == detail;
  }

  @override
  int get hashCode => detail.hashCode;
}
