import 'package:advanced_concepts/core/router/app_router_calls.dart';
import 'package:advanced_concepts/features/api_compare_lab/presentation/api_compare_lab_screen.dart';
import 'package:advanced_concepts/features/api_dio_lab/data/repositories/api_dio_lab_repository.dart';
import 'package:advanced_concepts/features/api_dio_lab/domain/entities/book.dart';
import 'package:advanced_concepts/features/api_dio_lab/presentation/api_dio_lab_screen.dart';
import 'package:advanced_concepts/features/api_general_lab/presentation/api_general_lab_screen.dart';
import 'package:advanced_concepts/features/api_handling/presentation/api_handling_screen.dart';
import 'package:advanced_concepts/features/api_http_lab/data/repositories/api_http_lab_repository.dart';
import 'package:advanced_concepts/features/api_http_lab/domain/entities/book.dart'
    as http_book;
import 'package:advanced_concepts/features/api_http_lab/presentation/api_http_lab_screen.dart';
import 'package:advanced_concepts/features/book_details/presentation/book_details_screen.dart';
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

import 'features/api_dio_lab/fake_api_dio_lab_repository.dart';
import 'features/api_http_lab/fake_api_http_lab_repository.dart';
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
    expect(find.text('API Handling'), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Navigation'), findsNothing);

    await _openRoutingLab(tester);

    expect(find.byType(RoutingLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Navigation'), findsOneWidget);
    expect(find.text(AppRouterCalls.go), findsOneWidget);
    expect(find.text(AppRouterCalls.goNamed), findsOneWidget);
    expect(find.text(AppRouterCalls.push), findsOneWidget);
    expect(find.text(AppRouterCalls.pushNamed), findsOneWidget);
    expect(find.text(AppRouterCalls.goViaRouter), findsOneWidget);
    expect(find.text(AppRouterCalls.pushNamedViaRouter), findsOneWidget);
    expect(find.text(AppRouterCalls.pop), findsOneWidget);
    expect(find.text(AppRouterCalls.replaceNamed), findsOneWidget);
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
    await tester.tap(find.text(AppRouterCalls.pushNamed));
    await tester.pumpAndSettle();

    expect(find.byType(UserListScreen), findsOneWidget);
    expect(
      GoRouter.of(tester.element(find.byType(UserListScreen))).canPop(),
      isTrue,
    );
    expect(find.text(AppRouterCalls.pushNamed), findsWidgets);
    expect(find.text('Routing Lab'), findsWidgets);
    expect(find.text('you are here'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(RoutingLabScreen), findsOneWidget);

    await tester.tap(find.text(AppRouterCalls.goNamed));
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
    await tester.tap(find.text(AppRouterCalls.goNamed));
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

    await tester.ensureVisible(find.text(AppRouterCalls.pop));
    await tester.tap(find.text(AppRouterCalls.pop));
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
      await tester.ensureVisible(find.text(AppRouterCalls.replaceNamed));
      await tester.tap(find.text(AppRouterCalls.replaceNamed));
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
    await tester.tap(find.text(AppRouterCalls.goNamed));
    await tester.pumpAndSettle();
    expect(find.byType(UserListScreen), findsOneWidget);

    await tester.tap(
      find.descendant(
        of: find.byType(UserListScreen),
        matching: find.text(AppRouterCalls.pop),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(UserListScreen), findsOneWidget);
    expect(find.text(AppRouterCalls.popBlocked), findsOneWidget);
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
    await tester.tap(find.text(AppRouterCalls.pushNamed));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ada'));
    await tester.pumpAndSettle();

    expect(find.byType(UserDetailsScreen), findsOneWidget);
    expect(find.text('ada@example.com'), findsOneWidget);
    expect(find.text(AppRouterCalls.userDetails(1)), findsWidgets);
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

  testWidgets('Landing API Handling tile opens API hub', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    await tester.tap(find.text('API Handling'));
    await tester.pumpAndSettle();

    expect(find.byType(ApiHandlingScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'API Handling'), findsOneWidget);
    expect(find.text('General'), findsOneWidget);
    expect(find.text('HTTP vs Dio'), findsOneWidget);
    expect(find.text('Example HTTP'), findsOneWidget);
    expect(find.text('Example Dio'), findsOneWidget);
  });

  testWidgets('API Handling General tile opens General Lab', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    await tester.tap(find.text('API Handling'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('General'));
    await tester.pumpAndSettle();

    expect(find.byType(ApiGeneralLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'General'), findsOneWidget);
  });

  testWidgets('API Handling HTTP vs Dio tile opens Compare Lab', (
    tester,
  ) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    await tester.tap(find.text('API Handling'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('HTTP vs Dio'));
    await tester.pumpAndSettle();

    expect(find.byType(ApiCompareLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'HTTP vs Dio'), findsOneWidget);
  });

  testWidgets('API Handling Example HTTP tile opens HTTP Lab', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          apiHttpLabRepositoryProvider.overrideWithValue(
            FakeApiHttpLabRepository(),
          ),
        ],
        child: const AdvancedConceptsApp(),
      ),
    );

    await tester.tap(find.text('API Handling'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Example HTTP'));
    await tester.pumpAndSettle();

    expect(find.byType(ApiHttpLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Example HTTP'), findsOneWidget);
  });

  testWidgets('API Handling Example Dio tile opens Dio Lab', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          apiDioLabRepositoryProvider.overrideWithValue(
            FakeApiDioLabRepository(),
          ),
        ],
        child: const AdvancedConceptsApp(),
      ),
    );

    await tester.tap(find.text('API Handling'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Example Dio'));
    await tester.pumpAndSettle();

    expect(find.byType(ApiDioLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Example Dio'), findsOneWidget);
  });

  testWidgets('Dio lab book tap opens the placeholder details screen', (
    tester,
  ) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          apiDioLabRepositoryProvider.overrideWithValue(
            FakeApiDioLabRepository(
              books: const [
                Book(
                  id: '3',
                  title: 'Fourth Wing',
                  author: 'Rebecca Yarros',
                  status: BookStatus.finished,
                ),
              ],
            ),
          ),
        ],
        child: const AdvancedConceptsApp(),
      ),
    );

    await tester.tap(find.text('API Handling'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Example Dio'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('api-dio-lab-book-3')));
    await tester.pumpAndSettle();

    expect(find.byType(BookDetailsScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Fourth Wing'), findsOneWidget);
    expect(find.byKey(const Key('book-details-3')), findsOneWidget);
  });

  testWidgets('HTTP lab book tap opens the placeholder details screen', (
    tester,
  ) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          apiHttpLabRepositoryProvider.overrideWithValue(
            FakeApiHttpLabRepository(
              books: const [
                http_book.Book(
                  id: '3',
                  title: 'Fourth Wing',
                  author: 'Rebecca Yarros',
                  status: http_book.BookStatus.finished,
                ),
              ],
            ),
          ),
        ],
        child: const AdvancedConceptsApp(),
      ),
    );

    await tester.tap(find.text('API Handling'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Example HTTP'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('api-http-lab-book-3')));
    await tester.pumpAndSettle();

    expect(find.byType(BookDetailsScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Fourth Wing'), findsOneWidget);
    expect(find.byKey(const Key('book-details-3')), findsOneWidget);
  });
}
