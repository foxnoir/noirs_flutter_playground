import 'package:advanced_concepts/core/router/not_found_screen.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('NotFoundScreen shows Missing and Go to Landing Screen', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: NotFoundScreen(),
      ),
    );

    expect(find.text('Missing'), findsOneWidget);
    expect(find.text('Go to Landing Screen'), findsOneWidget);
  });
}
