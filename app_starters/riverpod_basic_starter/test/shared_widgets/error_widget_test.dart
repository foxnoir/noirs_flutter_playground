import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basic_starter/l10n/app_localizations.dart';
import 'package:riverpod_basic_starter/shared_widgets/error_widget.dart';

void main() {
  testWidgets('ErrorWidget shows the icon and message', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ErrorWidget(message: 'Unfortunately, an error occurred.'),
        ),
      ),
    );

    expect(find.byIcon(Icons.error_outline), findsOneWidget);
    expect(find.text('Unfortunately, an error occurred.'), findsOneWidget);
  });

  testWidgets('ErrorWidget shows a retry button when given', (tester) async {
    var retried = false;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ErrorWidget(
            message: 'Unfortunately, an error occurred.',
            retryLabel: 'Retry',
            onRetry: () => retried = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Retry'));
    expect(retried, isTrue);
  });
}
