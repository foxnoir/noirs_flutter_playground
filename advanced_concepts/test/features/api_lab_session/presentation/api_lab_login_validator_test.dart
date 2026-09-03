import 'package:advanced_concepts/features/api_lab_session/presentation/api_lab_login_validator.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ApiLabLoginValidator validator;

  setUp(() async {
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    validator = ApiLabLoginValidator(l10n);
  });

  test('email rejects empty and missing @', () {
    expect(validator.email(null), 'Enter an email.');
    expect(validator.email('  '), 'Enter an email.');
    expect(validator.email('lab'), 'Enter an email with @.');
  });

  test('email accepts a trimmed address with @', () {
    expect(validator.email('  lab@example.com  '), isNull);
  });

  test('password rejects empty and short values', () {
    expect(validator.password(null), 'Enter a password.');
    expect(validator.password(''), 'Enter a password.');
    expect(validator.password('short'), 'Use at least 6 characters.');
  });

  test('password accepts six or more characters', () {
    expect(validator.password('secret'), isNull);
  });
}
