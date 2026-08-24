import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/scenarios/placeholder/presentation/scenario_placeholder_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

void main() {
  testWidgets('ScenarioPlaceholderScreen shows the scenario number', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ScenarioPlaceholderScreen(number: 2),
      ),
    );

    expect(find.text('Scenario 2'), findsNWidgets(2));
  });
}
