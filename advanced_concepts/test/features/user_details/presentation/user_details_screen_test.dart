import 'package:advanced_concepts/features/user_details/presentation/user_details_screen.dart';
import 'package:advanced_concepts/features/user_list/data/repositories/in_memory_user_list_repository.dart';
import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/error_widget.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../user_list/fake_user_list_repository.dart';

void main() {
  const ada = User(
    id: 1,
    nickname: 'Ada',
    email: 'ada@example.com',
    age: 36,
    imageUrl: '',
  );

  testWidgets('UserDetailsScreen shows nickname, email, and age', (
    tester,
  ) async {
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
          home: UserDetailsScreen(id: 1),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Ada'), findsOneWidget);
    expect(find.text('Nickname'), findsOneWidget);
    expect(find.text('Ada'), findsWidgets);
    expect(find.text('ada@example.com'), findsOneWidget);
    expect(find.text('36'), findsOneWidget);
  });

  testWidgets('UserDetailsScreen maps missing id to errorNotFound', (
    tester,
  ) async {
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
          home: UserDetailsScreen(id: 99),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ErrorWidget), findsOneWidget);
    expect(find.text('That user was not found.'), findsOneWidget);
  });
}
