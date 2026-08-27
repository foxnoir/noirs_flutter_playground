import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basics/core/router/page_not_found_screen.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/add_user_screen.dart';
import 'package:riverpod_basics/features/labs/consumer_widget/presentation/consumer_widget_screen.dart';
import 'package:riverpod_basics/features/labs/listen_manual/presentation/listen_manual_screen.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/provider_lifetimes_screen.dart';
import 'package:riverpod_basics/features/labs/quote/presentation/quote_screen.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/refresh_screen.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/user_list_screen.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/user_search_screen.dart';
import 'package:riverpod_basics/features/landing_page/presentation/landing_page.dart';
import 'package:riverpod_basics/features/providers/no_provider/presentation/no_provider_screen.dart';
import 'package:riverpod_basics/features/providers/state_provider/presentation/state_provider_screen.dart';
import 'package:riverpod_basics/main.dart';

void main() {
  testWidgets('Landing is the initial route', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    expect(find.byType(LandingPage), findsOneWidget);
    expect(find.text('Providers'), findsOneWidget);
    expect(find.text('Labs'), findsOneWidget);
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

  testWidgets('Landing navigates to AutoDispose Provider Lifetimes lab', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Labs'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('AutoDispose Provider Lifetimes'));
    await tester.pumpAndSettle();

    expect(find.byType(ProviderLifetimesScreen), findsOneWidget);
    expect(
      find.widgetWithText(AppBar, 'AutoDispose Provider Lifetimes'),
      findsOneWidget,
    );
  });

  testWidgets('Landing navigates to Add User lab', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Labs'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add User'));
    await tester.pumpAndSettle();

    expect(find.byType(AddUserScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Add User'), findsOneWidget);
  });

  testWidgets('Landing navigates to User List lab', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Labs'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('User List'));
    await tester.pumpAndSettle();

    expect(find.byType(UserListScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'User List'), findsOneWidget);
    expect(find.text('Grace'), findsOneWidget);
  });

  testWidgets('Landing navigates to User Search lab', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Labs'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('User Search'));
    await tester.pumpAndSettle();

    expect(find.byType(UserSearchScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'User Search'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Search'), findsOneWidget);
  });

  testWidgets('Landing navigates to Listen Manual lab', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Labs'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Listen Manual'));
    await tester.pumpAndSettle();

    expect(find.byType(ListenManualScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Listen Manual'), findsOneWidget);
    expect(find.text('Live value. Empty now.'), findsOneWidget);
  });

  testWidgets('Landing navigates to Consumer Widget lab', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Labs'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Consumer Widget'));
    await tester.pumpAndSettle();

    expect(find.byType(ConsumerWidgetScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Consumer Widget'), findsOneWidget);
    expect(find.text('StatelessWidget + Consumer'), findsOneWidget);
    expect(find.text('ConsumerWidget'), findsOneWidget);
  });

  testWidgets('Landing navigates to Quote lab', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Labs'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Quote'));
    await tester.pumpAndSettle();

    expect(find.byType(QuoteScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Quote'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Invalidate'), findsOneWidget);
    expect(
      find.widgetWithText(ElevatedButton, 'Fail call', skipOffstage: false),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(
        ElevatedButton,
        'Increment number',
        skipOffstage: false,
      ),
      findsOneWidget,
    );
  });

  testWidgets('Landing navigates to Refresh lab', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Labs'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Refresh'));
    await tester.pumpAndSettle();

    expect(find.byType(RefreshScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Refresh'), findsOneWidget);
    expect(find.textContaining('Fetch 1 ·'), findsOneWidget);
  });
}
