import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/user_list/data/repositories/in_memory_user_repository.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/providers/user_search_provider.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/user_search_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/error_widget.dart';
import 'package:riverpod_basics/shared_widgets/lab_intro_copy.dart';

import '../../user_list/fake_user_repository.dart';

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

  Widget app({
    required FakeUserRepository repository,
    Duration searchDelay = Duration.zero,
  }) {
    return ProviderScope(
      overrides: [
        userRepositoryProvider.overrideWithValue(repository),
        userSearchDelayProvider.overrideWithValue(searchDelay),
      ],
      child: const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: UserSearchScreen(),
      ),
    );
  }

  Finder notFoundDragon() {
    return find.byWidgetPredicate((widget) {
      if (widget is! Image) return false;
      final image = widget.image;
      return image is AssetImage &&
          image.assetName == ErrorWidget.notFoundImageAsset;
    });
  }

  Future<void> submitSearch(WidgetTester tester, String query) async {
    await tester.enterText(find.byType(TextField), query);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Search'));
  }

  testWidgets('empty query shows no users and no not-found illustration', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(repository: const FakeUserRepository(users: [grace, alan])),
    );
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'User Search'), findsOneWidget);
    expect(find.byType(LabIntroCopy), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Search'), findsOneWidget);
    expect(find.text('Notifier'), findsOneWidget);
    expect(find.text('Family'), findsOneWidget);
    expect(find.text('Grace'), findsNothing);
    expect(notFoundDragon(), findsNothing);

    final notifierBox = tester.getSize(
      find.byKey(const Key('userSearchNotifierPanel')),
    );
    final familyBox = tester.getSize(
      find.byKey(const Key('userSearchFamilyPanel')),
    );
    expect(notifierBox.height, greaterThan(120));
    expect(familyBox.height, closeTo(notifierBox.height, 1));
  });

  testWidgets('search by name shows the matching user', (tester) async {
    await tester.pumpWidget(
      app(repository: const FakeUserRepository(users: [grace, alan])),
    );
    await tester.pumpAndSettle();

    await submitSearch(tester, 'ala');
    await tester.pumpAndSettle();

    expect(find.text('Alan'), findsNWidgets(2));
    expect(find.text('alan@example.com · 41'), findsNWidgets(2));
    expect(find.text('Grace'), findsNothing);
    expect(notFoundDragon(), findsNothing);
  });

  testWidgets('search by id shows the matching user', (tester) async {
    await tester.pumpWidget(
      app(repository: const FakeUserRepository(users: [grace, alan])),
    );
    await tester.pumpAndSettle();

    await submitSearch(tester, '10');
    await tester.pumpAndSettle();

    expect(find.text('Grace'), findsNWidgets(2));
    expect(find.text('Alan'), findsNothing);
  });

  testWidgets('no match shows a spinner then the not-found dragon', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(
        repository: const FakeUserRepository(users: [grace, alan]),
        searchDelay: const Duration(milliseconds: 50),
      ),
    );
    await tester.pumpAndSettle();

    await submitSearch(tester, 'zzz');
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNWidgets(2));
    expect(notFoundDragon(), findsNothing);

    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(LabIntroCopy), findsOneWidget);
    expect(find.text('No user matched that search.'), findsOneWidget);
    expect(notFoundDragon(), findsOneWidget);
    expect(find.text('Notifier'), findsNothing);
    expect(find.text('Family'), findsNothing);
    expect(find.text('Grace'), findsNothing);
  });

  testWidgets('maps a fetch failure to l10n copy', (tester) async {
    await tester.pumpWidget(
      app(repository: const FakeUserRepository(error: NetworkFailure())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Error'), findsOneWidget);
    expect(
      find.text('Could not reach the server. Check your connection.'),
      findsOneWidget,
    );
  });
}
