import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/placeholder/presentation/lab_placeholder_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

void main() {
  testWidgets('LabPlaceholderScreen shows the lab number', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LabPlaceholderScreen(number: 2),
      ),
    );

    expect(find.text('Lab 2'), findsNWidgets(2));
  });
}
