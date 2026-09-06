import 'package:firebase_depth/features/items/data/repositories/in_memory_item_repository.dart';
import 'package:firebase_depth/features/items/domain/entities/item.dart';
import 'package:firebase_depth/features/items/presentation/item_detail_page.dart';
import 'package:firebase_depth/l10n/app_localizations.dart';
import 'package:firebase_depth/shared_widgets/error_widget.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_item_repository.dart';

void main() {
  const alpha = Item(id: 1, title: 'Alpha', subtitle: 'First sample item');

  testWidgets('ItemDetailPage shows the item', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          itemRepositoryProvider.overrideWithValue(
            const FakeItemRepository(items: [alpha]),
          ),
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ItemDetailPage(id: 1),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Alpha'), findsOneWidget);
    expect(find.text('First sample item'), findsOneWidget);
  });

  testWidgets('ItemDetailPage maps missing id to errorNotFound', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          itemRepositoryProvider.overrideWithValue(
            const FakeItemRepository(items: [alpha]),
          ),
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ItemDetailPage(id: 99),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ErrorWidget), findsOneWidget);
    expect(find.text('That item was not found.'), findsOneWidget);
  });
}
