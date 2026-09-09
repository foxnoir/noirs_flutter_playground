import 'package:firebase_in_depth/core/errors/app_exception.dart';
import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/core/errors/app_failure_message.dart';
import 'package:firebase_in_depth/l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = AppLocalizationsEn();

  test('AppFailure.message uses the l10n keys', () {
    expect(
      const NetworkFailure().message(l10n),
      'Sorry, there is a problem with the service. Try again later.',
    );
    expect(const NotFoundFailure().message(l10n), 'That item was not found.');
    expect(
      const PermissionFailure().message(l10n),
      'This write is not allowed. Deploy firestore.rules '
      '(only participants on a course), then tap Increment again.',
    );
    expect(
      const InvalidQueryFailure().message(l10n),
      'This query is not valid for Firestore.',
    );
    expect(
      const InvalidQueryFailure(detail: 'two inequalities').message(l10n),
      'two inequalities',
    );
    expect(
      const UnknownFailure().message(l10n),
      'Unfortunately, an error occurred.',
    );
    expect(
      const AuthFailure().message(l10n),
      "Couldn't sign in. Check email and password.",
    );
  });

  test('localizedError maps exceptions the same way', () {
    expect(
      localizedError(l10n, const NetworkException()),
      'Sorry, there is a problem with the service. Try again later.',
    );
    expect(
      localizedError(l10n, const NotFoundException()),
      'That item was not found.',
    );
    expect(
      localizedError(l10n, Exception('nope')),
      'Unfortunately, an error occurred.',
    );
  });
}
