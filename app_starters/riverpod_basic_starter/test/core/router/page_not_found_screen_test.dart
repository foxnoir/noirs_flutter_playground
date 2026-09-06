import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basic_starter/core/router/page_not_found_screen.dart';
import 'package:riverpod_basic_starter/l10n/app_localizations.dart';

void main() {
  testWidgets('PageNotFoundScreen shows Missing and Back', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: PageNotFoundScreen(),
      ),
    );

    expect(find.text('Missing'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
  });
}
