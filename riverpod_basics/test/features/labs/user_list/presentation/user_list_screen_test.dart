import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/user_list/data/repositories/in_memory_user_list_repository.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/user_list_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

import '../fake_user_list_repository.dart';

void main() {
  const grace = User(
    id: 10,
    username: 'Grace',
    age: 85,
    email: 'grace@example.com',
  );
  const alan = User(
    id: 11,
    username: 'Alan',
    age: 41,
    email: 'alan@example.com',
  );

  testWidgets('UserListScreen shows users from the list provider', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userListRepositoryProvider.overrideWithValue(
            const FakeUserListRepository(users: [grace, alan]),
          ),
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: UserListScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'User List'), findsOneWidget);
    expect(find.text('Grace'), findsOneWidget);
    expect(find.text('grace@example.com · 85'), findsOneWidget);
    expect(find.text('Alan'), findsOneWidget);
    expect(find.text('alan@example.com · 41'), findsOneWidget);
  });

  testWidgets('UserListScreen maps a fetch exception to l10n copy', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userListRepositoryProvider.overrideWithValue(
            const FakeUserListRepository(error: NetworkFailure()),
          ),
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: UserListScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Error'), findsOneWidget);
    expect(
      find.text('Could not reach the server. Check your connection.'),
      findsOneWidget,
    );
  });
}
