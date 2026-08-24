import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/landing_page/presentation/landing_page.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

void main() {
  Widget app({Locale locale = const Locale('en')}) {
    return MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LandingPage(),
    );
  }

  Future<void> expand(WidgetTester tester, String title) async {
    await tester.tap(find.text(title));
    await tester.pumpAndSettle();
  }

  testWidgets('Landing page shows Providers and Scenarios dropdowns', (
    tester,
  ) async {
    await tester.pumpWidget(app());

    expect(find.text('Riverpod Basics'), findsOneWidget);
    expect(find.text('Providers'), findsOneWidget);
    expect(find.text('Scenarios'), findsOneWidget);
    expect(find.text('No Provider'), findsNothing);
    expect(find.text('Current User'), findsNothing);
    expect(find.text('Scenario 1'), findsNothing);
  });

  testWidgets('Providers dropdown lists every destination', (tester) async {
    await tester.pumpWidget(app());
    await expand(tester, 'Providers');

    expect(find.text('No Provider'), findsOneWidget);
    expect(find.text('StateProvider'), findsOneWidget);
    expect(find.text('NotifierProvider'), findsOneWidget);
    expect(find.text('AsyncNotifier Persistent State'), findsOneWidget);
    expect(find.text('AsyncNotifier Non-Persistent State'), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsNWidgets(5));
  });

  testWidgets('Scenarios dropdown lists current user and placeholder rows', (
    tester,
  ) async {
    await tester.pumpWidget(app());
    await expand(tester, 'Scenarios');

    expect(find.text('Current User'), findsOneWidget);
    expect(find.text('Scenario 2'), findsOneWidget);
    expect(find.text('Scenario 3'), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsNWidgets(3));
  });

  testWidgets('Landing page lists destinations in German', (tester) async {
    await tester.pumpWidget(app(locale: const Locale('de')));

    expect(find.text('Szenarien'), findsOneWidget);
    await expand(tester, 'Providers');
    expect(find.text('Kein Provider'), findsOneWidget);
    await expand(tester, 'Szenarien');
    expect(find.text('Aktueller Benutzer'), findsOneWidget);
    expect(find.text('Szenario 2'), findsOneWidget);
  });
}
