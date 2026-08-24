import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/async_notifier_non_persistent_state/presentation/async_notifier_non_persistent_state_screen.dart';
import 'package:riverpod_basics/features/async_notifier_non_persistent_state/presentation/providers/async_notifier_non_persistent_state.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/main.dart';
import 'package:riverpod_basics/shared_widgets/error_widget.dart';

void main() {
  testWidgets('Non-Persistent screen increments, decrements and resets', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: AsyncNotifierNonPersistentStateScreen(),
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

  testWidgets('Non-Persistent State loads again after back', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Providers'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('AsyncNotifier Non-Persistent State'));
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

    await tester.tap(find.text('AsyncNotifier Non-Persistent State'));
    await tester.pump();
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

    expect(
      find.text('You have pressed the button this many times: 0'),
      findsOneWidget,
    );
  });

  testWidgets('Non-Persistent screen shows ErrorWidget when load fails', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          nonPersistentStateAsyncNotifierProvider.overrideWith(
            _FailingNonPersistentNotifier.new,
          ),
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: AsyncNotifierNonPersistentStateScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ErrorWidget), findsOneWidget);
    expect(find.text('Unfortunately, an error occurred.'), findsOneWidget);
  });
}

class _FailingNonPersistentNotifier extends NonPersistentStateAsyncNotifier {
  @override
  Future<int> build() async {
    throw Exception('load failed');
  }
}
