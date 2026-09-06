import 'package:firebase_in_depth/core/router/page_not_found_screen.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
