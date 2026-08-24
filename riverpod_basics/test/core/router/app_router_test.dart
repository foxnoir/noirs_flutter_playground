import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basics/core/router/page_not_found_screen.dart';
import 'package:riverpod_basics/features/landing_page/presentation/landing_page.dart';
import 'package:riverpod_basics/features/no_provider/presentation/no_provider_screen.dart';
import 'package:riverpod_basics/features/state_provider/presentation/state_provider_screen.dart';
import 'package:riverpod_basics/main.dart';

void main() {
  testWidgets('Landing is the initial route', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    expect(find.byType(LandingPage), findsOneWidget);
    expect(find.text('Providers'), findsOneWidget);
    expect(find.text('Scenarios'), findsOneWidget);
  });

  testWidgets('Landing navigates to StateProvider', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Providers'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('StateProvider'));
    await tester.pumpAndSettle();

    expect(find.byType(StateProviderScreen), findsOneWidget);
    expect(
      find.text('You have pressed the button this many times: 0'),
      findsOneWidget,
    );
  });

  testWidgets('Landing navigates to No Provider', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Providers'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('No Provider'));
    await tester.pumpAndSettle();

    expect(find.byType(NoProviderScreen), findsOneWidget);
  });

  testWidgets('Unknown path shows PageNotFoundScreen and returns to landing', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(LandingPage));
    GoRouter.of(context).go('/does-not-exist');
    await tester.pumpAndSettle();

    expect(find.byType(PageNotFoundScreen), findsOneWidget);
    expect(find.text('Page not found'), findsOneWidget);

    await tester.tap(find.text('Go to landing'));
    await tester.pumpAndSettle();

    expect(find.byType(LandingPage), findsOneWidget);
  });
}
