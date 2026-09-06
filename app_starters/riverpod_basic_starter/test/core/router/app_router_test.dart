import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basic_starter/core/router/page_not_found_screen.dart';
import 'package:riverpod_basic_starter/features/home/presentation/home_screen.dart';
import 'package:riverpod_basic_starter/features/item_details/presentation/item_details_screen.dart';
import 'package:riverpod_basic_starter/features/items/data/data_sources/in_memory_item_data_source.dart';
import 'package:riverpod_basic_starter/main.dart';

void main() {
  testWidgets('Unknown path shows PageNotFoundScreen', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: RiverpodBasicStarterApp()),
    );

    final context = tester.element(find.byType(HomeScreen));
    GoRouter.of(context).go('/does-not-exist');
    await tester.pumpAndSettle();

    expect(find.byType(PageNotFoundScreen), findsOneWidget);
    expect(find.text('Missing'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
  });

  testWidgets('Items navigates to item details', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          itemDataSourceProvider.overrideWithValue(
            const ItemDataSourceImpl(delay: Duration.zero),
          ),
        ],
        child: const RiverpodBasicStarterApp(),
      ),
    );

    await tester.tap(find.text('Items'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Alpha'));
    await tester.pumpAndSettle();

    expect(find.byType(ItemDetailsScreen), findsOneWidget);
    expect(find.text('First sample item'), findsOneWidget);
  });
}
