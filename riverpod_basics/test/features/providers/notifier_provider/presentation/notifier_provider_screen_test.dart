import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/providers/notifier_provider/presentation/notifier_provider_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

void main() {
  Widget app({required Widget home, ProviderContainer? container}) {
    final materialApp = MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    );

    if (container != null) {
      return UncontrolledProviderScope(
        container: container,
        child: materialApp,
      );
    }

    return ProviderScope(child: materialApp);
  }

  testWidgets('NotifierProviderScreen increments and decrements', (
    tester,
  ) async {
    await tester.pumpWidget(app(home: const NotifierProviderScreen()));

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
  });

  testWidgets('NotifierProviderScreen keeps count on the same container', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      app(container: container, home: const NotifierProviderScreen()),
    );
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    await tester.pumpWidget(
      app(container: container, home: const SizedBox.shrink()),
    );
    await tester.pumpWidget(
      app(container: container, home: const NotifierProviderScreen()),
    );

    expect(
      find.text('You have pressed the button this many times: 1'),
      findsOneWidget,
    );
  });
}
