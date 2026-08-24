import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/router/page_not_found_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

void main() {
  testWidgets('PageNotFoundScreen shows the title and go-to-landing button', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: PageNotFoundScreen(),
      ),
    );

    expect(find.text('Page not found'), findsOneWidget);
    expect(find.text('Go to landing'), findsOneWidget);
  });
}
