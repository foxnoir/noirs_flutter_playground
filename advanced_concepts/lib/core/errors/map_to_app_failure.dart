import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/core/errors/app_failure.dart';

/// For UI / demo notifiers that have no repository.
/// Repositories use AppFailure.fromException on AppException only.
AppFailure mapToAppFailure(Object error) {
  return switch (error) {
    AppFailure() => error,
    AppException() => AppFailure.fromException(error),
    _ => const UnknownFailure(),
  };
}
