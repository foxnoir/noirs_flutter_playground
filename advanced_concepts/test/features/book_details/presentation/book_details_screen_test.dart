import 'package:advanced_concepts/features/book_details/presentation/book_details_screen.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pumpBookScreen(
  WidgetTester tester, {
  required String bookId,
  String? title,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BookDetailsScreen(bookId: bookId, title: title),
    ),
  );
}

void main() {
  testWidgets('book details shows the title and the reading dragon', (
    tester,
  ) async {
    await _pumpBookScreen(tester, bookId: '3', title: 'Fourth Wing');

    expect(find.widgetWithText(AppBar, 'Fourth Wing'), findsOneWidget);
    expect(find.byKey(const Key('book-details-3')), findsOneWidget);
    expect(
      find.image(const AssetImage(BookDetailsScreen.dragonAsset)),
      findsOneWidget,
    );
    expect(find.text('Rebecca Yarros'), findsNothing);
  });

  testWidgets('book details falls back to Book Details when extra is missing', (
    tester,
  ) async {
    await _pumpBookScreen(tester, bookId: '3');

    expect(find.widgetWithText(AppBar, 'Book Details'), findsOneWidget);
  });
}
