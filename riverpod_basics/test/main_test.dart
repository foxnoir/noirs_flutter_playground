import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/landing_page/presentation/landing_page.dart';
import 'package:riverpod_basics/main.dart';

void main() {
  testWidgets('RiverpodBasicsApp starts on the landing page', (tester) async {
    // ProviderScope creates the ProviderContainer for the widget tree.
    // Without it, ref.watch / ref.read throw.
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    expect(find.byType(LandingPage), findsOneWidget);
    expect(find.text('Riverpod Basics'), findsWidgets);
    // Intentional failure: verify pre-push blocks and shows a warning.
    expect(find.text('THIS_FAILURE_IS_INTENTIONAL'), findsOneWidget);
  });

  testWidgets(
    'RiverpodBasicsApp stays English when the platform locale is German',
    (tester) async {
      tester.platformDispatcher.localeTestValue = const Locale('de');
      tester.platformDispatcher.localesTestValue = [const Locale('de')];
      addTearDown(tester.platformDispatcher.clearLocaleTestValue);
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);

      await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
      await tester.pumpAndSettle();

      expect(find.text('Scenarios'), findsOneWidget);
      expect(find.text('Szenarien'), findsNothing);
    },
  );
}
