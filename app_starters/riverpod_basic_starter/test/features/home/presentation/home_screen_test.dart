import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basic_starter/features/home/presentation/home_screen.dart';
import 'package:riverpod_basic_starter/features/items/data/data_sources/in_memory_item_data_source.dart';
import 'package:riverpod_basic_starter/features/items/presentation/items_screen.dart';
import 'package:riverpod_basic_starter/l10n/app_localizations.dart';
import 'package:riverpod_basic_starter/main.dart';

void main() {
  testWidgets('Home lists Items, Two, and Three', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: HomeScreen(),
      ),
    );

    expect(find.text('Items'), findsOneWidget);
    expect(find.text('Two'), findsOneWidget);
    expect(find.text('Three'), findsOneWidget);
  });

  testWidgets('Home navigates to Items', (tester) async {
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

    expect(find.byType(ItemsScreen), findsOneWidget);
    expect(find.text('Alpha'), findsOneWidget);
  });
}
