import 'package:advanced_concepts/core/errors/app_failure.dart';
import 'package:advanced_concepts/core/errors/map_to_app_failure.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';

extension AppFailureMessage on AppFailure {
  String message(AppLocalizations l10n) {
    return switch (this) {
      NetworkFailure() => l10n.errorNetwork,
      NotFoundFailure() => l10n.errorNotFound,
      UnknownFailure() => l10n.errorOccurred,
    };
  }
}

String localizedError(AppLocalizations l10n, Object error) {
  return mapToAppFailure(error).message(l10n);
}
