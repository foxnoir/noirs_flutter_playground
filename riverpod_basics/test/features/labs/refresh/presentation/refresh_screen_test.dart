import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/theme/theme.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/providers/refresh_provider.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/refresh_screen.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/widgets/refresh_blink_button.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

void main() {
  /// [ProviderScope] must be the direct `pumpWidget` argument. Otherwise
  /// riverpod_lint treats the override as a nested scope.
  Future<void> pumpRefreshApp(
    WidgetTester tester, {
    Duration delay = Duration.zero,
  }) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [refreshPingDelayProvider.overrideWithValue(delay)],
        child: MaterialApp(
          locale: const Locale('en'),
          theme: getLightTheme(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const RefreshScreen(),
        ),
      ),
    );
  }

  Finder labButton(String label) {
    return find.widgetWithText(
      FullWidthElevatedButton,
      label,
      skipOffstage: false,
    );
  }

  Future<void> tapLabButton(WidgetTester tester, String label) async {
    await tester.scrollUntilVisible(labButton(label), 80);
    await tester.pumpAndSettle();
    await tester.tap(labButton(label));
  }

  testWidgets('shows fetch 1 after the first GET', (tester) async {
    await pumpRefreshApp(tester);
    await tester.pumpAndSettle();

    expect(find.text('watch'), findsOneWidget);
    expect(find.textContaining('Fetch 1 ·'), findsOneWidget);
  });

  testWidgets('Refresh button waits on the Future', (tester) async {
    await pumpRefreshApp(tester, delay: const Duration(milliseconds: 50));
    await tester.pumpAndSettle();

    await tapLabButton(tester, 'Refresh');
    await tester.pump();

    expect(find.text('Waiting on Future…'), findsOneWidget);
    expect(find.text('Loading…'), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('Waiting on Future…'), findsNothing);
    expect(find.textContaining('Fetch 2 ·'), findsOneWidget);
  });

  testWidgets('Invalidate does not wait on the button', (tester) async {
    await pumpRefreshApp(tester, delay: const Duration(milliseconds: 50));
    await tester.pumpAndSettle();

    await tapLabButton(tester, 'Invalidate');
    await tester.pump();

    expect(find.text('Waiting on Future…'), findsNothing);
    expect(
      find.widgetWithText(FullWidthElevatedButton, 'Refresh'),
      findsOneWidget,
    );
    expect(find.text('Loading…'), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.textContaining('Fetch 2 ·'), findsOneWidget);
  });

  testWidgets('Invalidate 3x starts one GET', (tester) async {
    await pumpRefreshApp(tester);
    await tester.pumpAndSettle();

    await tapLabButton(tester, 'Invalidate 3x');
    await tester.pumpAndSettle();

    expect(find.textContaining('Fetch 2 ·'), findsOneWidget);
  });

  testWidgets('Refresh 3x waits on 3 Futures and starts three GETs', (
    tester,
  ) async {
    await pumpRefreshApp(tester, delay: const Duration(milliseconds: 50));
    await tester.pumpAndSettle();

    await tapLabButton(tester, 'Refresh 3x');
    await tester.pump();

    expect(find.text('Waiting on 3 Futures…'), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('Waiting on 3 Futures…'), findsNothing);
    expect(find.textContaining('Fetch 4 ·'), findsOneWidget);
  });

  testWidgets('Refresh button blinks once', (tester) async {
    await pumpRefreshApp(tester, delay: const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    await tapLabButton(tester, 'Refresh');
    await tester.pump();

    expect(_blinkOpacity(tester, 'Waiting on Future…'), 0.55);
    await tester.pump(const Duration(milliseconds: 140));
    expect(_blinkOpacity(tester, 'Waiting on Future…'), 0);

    await tester.pumpAndSettle();
  });

  testWidgets('Refresh 3x blinks the button three times', (tester) async {
    await pumpRefreshApp(tester, delay: const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    await tapLabButton(tester, 'Refresh 3x');
    await tester.pump();

    const onFor = Duration(milliseconds: 140);
    const offFor = Duration(milliseconds: 100);

    expect(_blinkOpacity(tester, 'Waiting on 3 Futures…'), 0.55);
    await tester.pump(onFor);
    expect(_blinkOpacity(tester, 'Waiting on 3 Futures…'), 0);
    await tester.pump(offFor);
    expect(_blinkOpacity(tester, 'Waiting on 3 Futures…'), 0.55);
    await tester.pump(onFor);
    expect(_blinkOpacity(tester, 'Waiting on 3 Futures…'), 0);
    await tester.pump(offFor);
    expect(_blinkOpacity(tester, 'Waiting on 3 Futures…'), 0.55);

    await tester.pumpAndSettle();
  });
}

double _blinkOpacity(WidgetTester tester, String label) {
  final button = find.ancestor(
    of: find.text(label),
    matching: find.byType(RefreshBlinkButton),
  );
  return tester
      .widget<AnimatedOpacity>(
        find.descendant(of: button, matching: find.byType(AnimatedOpacity)),
      )
      .opacity;
}
