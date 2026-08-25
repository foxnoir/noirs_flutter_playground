import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/theme/theme.dart';
import 'package:riverpod_basics/features/labs/add_user/data/repositories/in_memory_user_repository.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/add_user_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

import '../fake_user_repository.dart';

void main() {
  Widget addUserApp() {
    return ProviderScope(
      overrides: [
        userRepositoryProvider.overrideWithValue(const FakeUserRepository()),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        theme: getLightTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const AddUserScreen(),
      ),
    );
  }

  Future<void> addAda(WidgetTester tester) async {
    await tester.enterText(find.widgetWithText(TextFormField, 'Id'), '1');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'Ada',
    );
    await tester.enterText(find.widgetWithText(TextFormField, 'Age'), '36');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'ada@example.com',
    );
    await tester.tap(find.byType(FullWidthElevatedButton));
    await tester.pumpAndSettle();
  }

  testWidgets('AddUserScreen adds a user to the list', (tester) async {
    await tester.pumpWidget(addUserApp());
    await tester.pumpAndSettle();

    await addAda(tester);

    expect(find.text('Ada'), findsOneWidget);
    expect(find.text('ada@example.com · 36'), findsOneWidget);
    expect(find.text('User added.'), findsOneWidget);
  });

  testWidgets('AddUserScreen shows a dialog for a duplicate id', (
    tester,
  ) async {
    await tester.pumpWidget(addUserApp());
    await tester.pumpAndSettle();

    await addAda(tester);
    await addAda(tester);

    expect(find.text('Error'), findsOneWidget);
    expect(find.text('A user with this id already exists.'), findsOneWidget);
  });
}
