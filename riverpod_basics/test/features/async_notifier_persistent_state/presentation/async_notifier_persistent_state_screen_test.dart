import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/async_notifier_persistent_state/presentation/async_notifier_persistent_state_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/main.dart';
import 'package:riverpod_basics/shared_widgets/error_widget.dart';

void main() {
  Widget app({required ProviderContainer container, required Widget home}) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: home,
      ),
    );
  }

  testWidgets('Persistent screen increments, decrements and resets', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: AsyncNotifierPersistentStateScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

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

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
    expect(
      find.text('You have pressed the button this many times: 0'),
      findsOneWidget,
    );
  });

  testWidgets('Persistent screen fakes an error on every 3rd enter', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Future<void> openScreen() async {
      await tester.pumpWidget(
        app(
          container: container,
          home: const AsyncNotifierPersistentStateScreen(),
        ),
      );
      await tester.pump();
    }

    Future<void> leaveScreen() async {
      await tester.pumpWidget(
        app(container: container, home: const SizedBox.shrink()),
      );
      await tester.pump();
    }

    await openScreen();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
    expect(
      find.text('You have pressed the button this many times: 0'),
      findsOneWidget,
    );

    await leaveScreen();
    await openScreen();
    expect(
      find.text('You have pressed the button this many times: 0'),
      findsOneWidget,
    );

    await leaveScreen();
    await openScreen();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
    expect(find.byType(ErrorWidget), findsOneWidget);
    expect(find.text('Unfortunately, an error occurred.'), findsOneWidget);

    await leaveScreen();
    await openScreen();
    expect(
      find.text('You have pressed the button this many times: 0'),
      findsOneWidget,
    );
  });

  testWidgets('Persistent State keeps count after back', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('AsyncNotifier Persistent State'));
    await tester.pump();
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(
      find.text('You have pressed the button this many times: 1'),
      findsOneWidget,
    );

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('AsyncNotifier Persistent State'));
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(
      find.text('You have pressed the button this many times: 1'),
      findsOneWidget,
    );
  });
}
