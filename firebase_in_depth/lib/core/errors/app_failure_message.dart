import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';

extension AppFailureMessage on AppFailure {
  String message(AppLocalizations l10n) {
    return switch (this) {
      NetworkFailure() => l10n.errorNetwork,
      NotFoundFailure() => l10n.errorNotFound,
      PermissionFailure() => l10n.errorPermission,
      InvalidQueryFailure(:final detail) =>
        (detail == null || detail.isEmpty) ? l10n.errorInvalidQuery : detail,
      UnknownFailure() => l10n.errorOccurred,
    };
  }
}

String localizedError(AppLocalizations l10n, Object error) {
  return AppFailure.from(error).message(l10n);
}
