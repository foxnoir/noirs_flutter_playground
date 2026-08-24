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

  testWidgets('Landing page lists every destination in English', (
    tester,
  ) async {
    await tester.pumpWidget(app());

    expect(find.text('Riverpod Basics'), findsOneWidget);
    expect(find.text('No Provider'), findsOneWidget);
    expect(find.text('StateProvider'), findsOneWidget);
    expect(find.text('NotifierProvider'), findsOneWidget);
    expect(find.text('AsyncNotifier Persistent State'), findsOneWidget);
    expect(find.text('AsyncNotifier Non-Persistent State'), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsNWidgets(5));
  });

  testWidgets('Landing page lists destinations in German', (tester) async {
    await tester.pumpWidget(app(locale: const Locale('de')));

    expect(find.text('Kein Provider'), findsOneWidget);
    expect(find.text('StateProvider'), findsOneWidget);
    expect(find.text('NotifierProvider'), findsOneWidget);
  });
}
