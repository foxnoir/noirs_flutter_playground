import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basic_starter/core/errors/app_exception.dart';
import 'package:riverpod_basic_starter/core/errors/app_failure.dart';
import 'package:riverpod_basic_starter/core/errors/app_failure_message.dart';
import 'package:riverpod_basic_starter/l10n/app_localizations_en.dart';

void main() {
  final l10n = AppLocalizationsEn();

  test('AppFailure.message uses the l10n keys', () {
    expect(
      const NetworkFailure().message(l10n),
      'Could not reach the server. Check your connection.',
    );
    expect(const NotFoundFailure().message(l10n), 'That item was not found.');
    expect(
      const UnknownFailure().message(l10n),
      'Unfortunately, an error occurred.',
    );
  });

  test('localizedError maps exceptions the same way', () {
    expect(
      localizedError(l10n, const NetworkException()),
      'Could not reach the server. Check your connection.',
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
