import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/providers/no_provider/presentation/no_provider_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

void main() {
  Future<void> pumpScreen(WidgetTester tester) {
    return tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: NoProviderScreen(),
      ),
    );
  }

  testWidgets('NoProviderScreen increments and decrements local state', (
    tester,
  ) async {
    await pumpScreen(tester);

    expect(
      find.text('You have pressed the button this many times: 0'),
      findsOneWidget,
    );

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(
      find.text('You have pressed the button this many times: 1'),
      findsOneWidget,
    );

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(
      find.text('You have pressed the button this many times: 0'),
      findsOneWidget,
    );

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(
      find.text('You have pressed the button this many times: -1'),
      findsOneWidget,
    );
  });

  testWidgets('NoProviderScreen starts at 0 again after a new widget', (
    tester,
  ) async {
    await pumpScreen(tester);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizedBox.shrink(),
      ),
    );
    await pumpScreen(tester);

    expect(
      find.text('You have pressed the button this many times: 0'),
      findsOneWidget,
    );
  });
}
