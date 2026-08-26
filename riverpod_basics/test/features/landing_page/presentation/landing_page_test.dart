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

  testWidgets('Landing page shows Providers and Labs dropdowns', (
    tester,
  ) async {
    await tester.pumpWidget(app());

    expect(find.text('Riverpod Basics'), findsOneWidget);
    expect(find.text('Providers'), findsOneWidget);
    expect(find.text('Labs'), findsOneWidget);
    expect(find.text('No Provider'), findsNothing);
    expect(find.text('AutoDispose Provider Lifetimes'), findsNothing);
    expect(find.text('Add User'), findsNothing);
    expect(find.text('User List'), findsNothing);
    expect(find.text('Lab 1'), findsNothing);
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

  testWidgets(
    'Labs dropdown lists lifetimes, add user, user list, listen manual, and a placeholder',
    (tester) async {
      await tester.pumpWidget(app());
      await expand(tester, 'Labs');

      expect(find.text('AutoDispose Provider Lifetimes'), findsOneWidget);
      expect(find.text('Add User'), findsOneWidget);
      expect(find.text('User List'), findsOneWidget);
      expect(find.text('Listen Manual'), findsOneWidget);
      expect(find.text('Lab 3'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsNWidgets(5));
    },
  );

  testWidgets('Landing page lists destinations in German', (tester) async {
    await tester.pumpWidget(app(locale: const Locale('de')));

    expect(find.text('Labs'), findsOneWidget);
    await expand(tester, 'Providers');
    expect(find.text('Kein Provider'), findsOneWidget);
    await expand(tester, 'Labs');
    expect(find.text('AutoDispose Provider Lifetimes'), findsOneWidget);
    expect(find.text('Benutzer hinzufügen'), findsOneWidget);
    expect(find.text('Benutzerliste'), findsOneWidget);
    expect(find.text('Listen Manual'), findsOneWidget);
    expect(find.text('Lab 3'), findsOneWidget);
  });
}
