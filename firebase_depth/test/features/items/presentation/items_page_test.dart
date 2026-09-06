import 'package:firebase_depth/core/errors/app_failure.dart';
import 'package:firebase_depth/features/items/data/repositories/in_memory_item_repository.dart';
import 'package:firebase_depth/features/items/domain/entities/item.dart';
import 'package:firebase_depth/features/items/presentation/items_page.dart';
import 'package:firebase_depth/l10n/app_localizations.dart';
import 'package:firebase_depth/shared_widgets/error_widget.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_item_repository.dart';

void main() {
  const alpha = Item(id: 1, title: 'Alpha', subtitle: 'First sample item');

  testWidgets('ItemsPage shows items from the repository', (tester) async {
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
          home: ItemsPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Items'), findsOneWidget);
    expect(find.text('Alpha'), findsOneWidget);
    expect(find.text('First sample item'), findsOneWidget);
  });

  testWidgets('ItemsPage maps a fetch failure to l10n copy', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          itemRepositoryProvider.overrideWithValue(
            const FakeItemRepository(error: NetworkFailure()),
          ),
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ItemsPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ErrorWidget), findsOneWidget);
    expect(
      find.text('Could not reach the server. Check your connection.'),
      findsOneWidget,
    );
    expect(find.text('Retry'), findsOneWidget);
  });
}
