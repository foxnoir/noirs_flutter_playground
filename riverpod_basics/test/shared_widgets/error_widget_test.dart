import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/error_widget.dart';

void main() {
  testWidgets('ErrorWidget shows the placeholder image and message', (
    tester,
  ) async {
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

    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Unfortunately, an error occurred.'), findsOneWidget);
  });

  testWidgets('ErrorWidget shows a German message', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('de'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ErrorWidget(message: 'Es ist leider ein Fehler aufgetreten.'),
        ),
      ),
    );

    expect(find.text('Es ist leider ein Fehler aufgetreten.'), findsOneWidget);
  });
}
