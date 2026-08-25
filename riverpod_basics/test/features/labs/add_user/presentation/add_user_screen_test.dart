import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/theme/theme.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/add_user_screen.dart';
import 'package:riverpod_basics/features/labs/user_list/data/repositories/in_memory_user_repository.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

import '../../user_list/fake_user_repository.dart';

void main() {
  Widget addUserApp({
    FakeUserRepository repository = const FakeUserRepository(),
  }) {
    return ProviderScope(
      overrides: [userRepositoryProvider.overrideWithValue(repository)],
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

  testWidgets('AddUserScreen shows users from the user list', (tester) async {
    await tester.pumpWidget(
      addUserApp(
        repository: const FakeUserRepository(
          users: [
            User(
              id: 10,
              username: 'Grace',
              age: 85,
              email: 'grace@example.com',
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Grace'), findsOneWidget);
    expect(find.text('grace@example.com · 85'), findsOneWidget);
  });

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

  testWidgets('AddUserScreen shows a dialog for a duplicate email', (
    tester,
  ) async {
    await tester.pumpWidget(addUserApp());
    await tester.pumpAndSettle();

    await addAda(tester);
    await tester.enterText(find.widgetWithText(TextFormField, 'Id'), '2');
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

    expect(find.text('Error'), findsOneWidget);
    expect(find.text('A user with this email already exists.'), findsOneWidget);
  });
}
