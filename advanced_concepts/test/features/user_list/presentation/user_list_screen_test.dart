import 'package:advanced_concepts/core/errors/app_failure.dart';
import 'package:advanced_concepts/features/user_list/data/repositories/in_memory_user_list_repository.dart';
import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';
import 'package:advanced_concepts/features/user_list/presentation/user_list_screen.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/error_widget.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_user_list_repository.dart';

void main() {
  const ada = User(
    id: 1,
    nickname: 'Ada',
    email: 'ada@example.com',
    age: 36,
    imageUrl: '',
  );

  testWidgets('UserListScreen shows users from the repository', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userListRepositoryProvider.overrideWithValue(
            const FakeUserListRepository(users: [ada]),
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
    expect(find.text('Ada'), findsOneWidget);
    expect(find.text('ada@example.com · 36'), findsOneWidget);
  });

  testWidgets('UserListScreen maps a fetch failure to l10n copy', (
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

    expect(find.byType(ErrorWidget), findsOneWidget);
    expect(
      find.text('Could not reach the server. Check your connection.'),
      findsOneWidget,
    );
    expect(find.text('Retry'), findsOneWidget);
  });
}
