import 'package:advanced_concepts/l10n/app_localizations.dart';

/// Tear-off validators for the DELETE-lab login form.
///
/// Pass `validator.email` / `validator.password` to `TextFormField.validator`.
/// Calling `email(value)` in the widget would run immediately and pass a
/// `String?` into `validator`, which is wrong.
///
/// This is UI validation, not session state. Authorized lives on
/// `ApiLabSessionNotifier`.
class ApiLabLoginValidator {
  const ApiLabLoginValidator(this.l10n);

  final AppLocalizations l10n;

  String? email(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return l10n.apiLabLoginEmailRequired;
    }
    if (!trimmed.contains('@')) {
      return l10n.apiLabLoginEmailInvalid;
    }
    return null;
  }

  String? password(String? value) {
    if (value == null || value.isEmpty) {
      return l10n.apiLabLoginPasswordRequired;
    }
    if (value.length < 6) {
      return l10n.apiLabLoginPasswordShort;
    }
    return null;
  }
}
