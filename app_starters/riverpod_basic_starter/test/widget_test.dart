import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basic_starter/features/home/presentation/home_page.dart';
import 'package:riverpod_basic_starter/features/items/data/data_sources/in_memory_item_data_source.dart';
import 'package:riverpod_basic_starter/features/items/presentation/item_detail_page.dart';
import 'package:riverpod_basic_starter/features/items/presentation/items_page.dart';
import 'package:riverpod_basic_starter/main.dart';

void main() {
  final delayOverride = itemDataSourceProvider.overrideWithValue(
    const InMemoryItemDataSource(delay: Duration.zero),
  );

  testWidgets('Home is the initial route', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: RiverpodBasicStarterApp()),
    );

    expect(find.text('Items'), findsOneWidget);
    expect(find.text('Two'), findsOneWidget);
    expect(find.text('Three'), findsOneWidget);
  });

  testWidgets('Home navigates to Items', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [delayOverride],
        child: const RiverpodBasicStarterApp(),
      ),
    );

    await tester.tap(find.text('Items'));
    await tester.pumpAndSettle();

    expect(find.byType(ItemsPage), findsOneWidget);
    expect(find.text('Alpha'), findsOneWidget);
  });

  testWidgets('Items navigates to item detail', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [delayOverride],
        child: const RiverpodBasicStarterApp(),
      ),
    );

    await tester.tap(find.text('Items'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Alpha'));
    await tester.pumpAndSettle();

    expect(find.byType(ItemDetailPage), findsOneWidget);
    expect(find.text('First sample item'), findsOneWidget);
  });

  testWidgets('Unknown path shows PageNotFoundScreen', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: RiverpodBasicStarterApp()),
    );

    final context = tester.element(find.byType(HomePage));
    GoRouter.of(context).go('/does-not-exist');
    await tester.pumpAndSettle();

    expect(find.text('Missing'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
  });
}
