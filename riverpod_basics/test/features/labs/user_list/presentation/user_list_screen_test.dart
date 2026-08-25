import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/presentation/user_list_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

void main() {
  testWidgets('UserListScreen shows a dummy list', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: UserListScreen(),
      ),
    );

    expect(find.widgetWithText(AppBar, 'User List'), findsOneWidget);
    expect(find.text('Grace'), findsOneWidget);
    expect(find.text('grace@example.com · 85'), findsOneWidget);
    expect(find.text('Alan'), findsOneWidget);
    expect(find.text('alan@example.com · 41'), findsOneWidget);
  });
}
