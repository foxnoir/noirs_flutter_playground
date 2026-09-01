import 'package:advanced_concepts/core/router/nav_calls.dart';
import 'package:advanced_concepts/features/landing/presentation/landing_screen.dart';
import 'package:advanced_concepts/features/layout_lab/presentation/layout_lab_screen.dart';
import 'package:advanced_concepts/features/lists_lab/presentation/lists_lab_screen.dart';
import 'package:advanced_concepts/features/routing_lab/presentation/routing_lab_screen.dart';
import 'package:advanced_concepts/features/user_details/presentation/user_details_screen.dart';
import 'package:advanced_concepts/features/user_list/data/data_sources/in_memory_user_list_data_source.dart';
import 'package:advanced_concepts/features/user_list/data/repositories/in_memory_user_list_repository.dart';
import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';
import 'package:advanced_concepts/features/user_list/presentation/user_list_screen.dart';
import 'package:advanced_concepts/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'features/user_list/fake_user_list_repository.dart';

void _useTallSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> _openRoutingLab(WidgetTester tester) async {
  await tester.tap(find.text('Navigation'));
  await tester.pumpAndSettle();
}

void main() {
  const ada = User(
    id: 1,
    nickname: 'Ada',
    email: 'ada@example.com',
    age: 36,
    imageUrl: '',
  );

  final delayOverride = userListDataSourceProvider.overrideWithValue(
    const InMemoryUserListDataSource(delay: Duration.zero),
  );

  testWidgets('Landing Screen lists Navigation and opens Routing Lab', (
    tester,
  ) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    expect(find.byType(LandingScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Advanced Concepts'), findsOneWidget);
    expect(find.text('Navigation'), findsOneWidget);
    expect(find.text('Layout'), findsOneWidget);
    expect(find.text('Lists'), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Navigation'), findsNothing);

    await _openRoutingLab(tester);

    expect(find.byType(RoutingLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Navigation'), findsOneWidget);
    expect(find.text(NavCalls.go), findsOneWidget);
    expect(find.text(NavCalls.goNamed), findsOneWidget);
    expect(find.text(NavCalls.push), findsOneWidget);
    expect(find.text(NavCalls.pushNamed), findsOneWidget);
    expect(find.text(NavCalls.goViaRouter), findsOneWidget);
    expect(find.text(NavCalls.pushNamedViaRouter), findsOneWidget);
    expect(find.text(NavCalls.pop), findsOneWidget);
    expect(find.text(NavCalls.replaceNamed), findsOneWidget);
  });

  testWidgets('pushNamed keeps Routing Lab on the stack; goNamed does not', (
    tester,
  ) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [delayOverride],
        child: const AdvancedConceptsApp(),
      ),
    );

    await _openRoutingLab(tester);
    await tester.tap(find.text(NavCalls.pushNamed));
    await tester.pumpAndSettle();

    expect(find.byType(UserListScreen), findsOneWidget);
    expect(
      GoRouter.of(tester.element(find.byType(UserListScreen))).canPop(),
      isTrue,
    );
    expect(find.text(NavCalls.pushNamed), findsWidgets);
    expect(find.text('Routing Lab'), findsWidgets);
    expect(find.text('you are here'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(RoutingLabScreen), findsOneWidget);

    await tester.tap(find.text(NavCalls.goNamed));
    await tester.pumpAndSettle();

    expect(find.byType(UserListScreen), findsOneWidget);
    expect(
      GoRouter.of(tester.element(find.byType(UserListScreen))).canPop(),
      isFalse,
    );
    expect(find.text('Routing Lab'), findsNothing);
    expect(find.text('go wiped Routing Lab — nothing to pop.'), findsOneWidget);
  });

  testWidgets('Go to Landing Screen from goNamed returns to Landing Screen', (
    tester,
  ) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [delayOverride],
        child: const AdvancedConceptsApp(),
      ),
    );

    await _openRoutingLab(tester);
    await tester.tap(find.text(NavCalls.goNamed));
    await tester.pumpAndSettle();
    expect(find.byType(UserListScreen), findsOneWidget);

    await tester.tap(find.byKey(const Key('go-to-landing')));
    await tester.pumpAndSettle();
    expect(find.byType(LandingScreen), findsOneWidget);
  });

  testWidgets('pop from Routing Lab returns to Landing Screen', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    await _openRoutingLab(tester);
    expect(find.byType(RoutingLabScreen), findsOneWidget);

    await tester.ensureVisible(find.text(NavCalls.pop));
    await tester.tap(find.text(NavCalls.pop));
    await tester.pumpAndSettle();
    expect(find.byType(LandingScreen), findsOneWidget);
  });

  testWidgets(
    'replaceNamed swaps Routing Lab; Back returns to Landing Screen',
    (tester) async {
      _useTallSurface(tester);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [delayOverride],
          child: const AdvancedConceptsApp(),
        ),
      );

      await _openRoutingLab(tester);
      await tester.ensureVisible(find.text(NavCalls.replaceNamed));
      await tester.tap(find.text(NavCalls.replaceNamed));
      await tester.pumpAndSettle();

      expect(find.byType(UserListScreen), findsOneWidget);
      expect(
        GoRouter.of(tester.element(find.byType(UserListScreen))).canPop(),
        isTrue,
      );
      expect(find.text('Landing Screen'), findsOneWidget);
      expect(find.byType(RoutingLabScreen), findsNothing);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.byType(LandingScreen), findsOneWidget);
      expect(find.byType(RoutingLabScreen), findsNothing);
    },
  );

  testWidgets('pop after goNamed does not leave User List', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [delayOverride],
        child: const AdvancedConceptsApp(),
      ),
    );

    await _openRoutingLab(tester);
    await tester.tap(find.text(NavCalls.goNamed));
    await tester.pumpAndSettle();
    expect(find.byType(UserListScreen), findsOneWidget);

    await tester.tap(
      find.descendant(
        of: find.byType(UserListScreen),
        matching: find.text(NavCalls.pop),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(UserListScreen), findsOneWidget);
    expect(find.text(NavCalls.popBlocked), findsOneWidget);
  });

  testWidgets('User List pushNamed opens User Details', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userListRepositoryProvider.overrideWithValue(
            const FakeUserListRepository(users: [ada]),
          ),
        ],
        child: const AdvancedConceptsApp(),
      ),
    );

    await _openRoutingLab(tester);
    await tester.tap(find.text(NavCalls.pushNamed));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ada'));
    await tester.pumpAndSettle();

    expect(find.byType(UserDetailsScreen), findsOneWidget);
    expect(find.text('ada@example.com'), findsOneWidget);
    expect(find.text(NavCalls.userDetails(1)), findsWidgets);
  });

  testWidgets('Unknown path shows NotFoundScreen', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [delayOverride],
        child: const AdvancedConceptsApp(),
      ),
    );

    final context = tester.element(find.byType(LandingScreen));
    GoRouter.of(context).go('/does-not-exist');
    await tester.pumpAndSettle();

    expect(find.text('Missing'), findsOneWidget);
    expect(find.text('Go to Landing Screen'), findsOneWidget);
  });

  testWidgets('Landing Layout tile opens Layout Lab', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    await tester.tap(find.text('Layout'));
    await tester.pumpAndSettle();

    expect(find.byType(LayoutLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Layout'), findsOneWidget);
  });

  testWidgets('Landing Lists tile opens Lists Lab', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    await tester.tap(find.text('Lists'));
    await tester.pumpAndSettle();

    expect(find.byType(ListsLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Lists'), findsOneWidget);
  });
}
