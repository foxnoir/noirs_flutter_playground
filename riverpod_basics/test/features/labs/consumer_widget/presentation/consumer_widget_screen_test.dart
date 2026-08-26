import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/theme/theme.dart';
import 'package:riverpod_basics/features/labs/consumer_widget/presentation/consumer_widget_screen.dart';
import 'package:riverpod_basics/features/labs/user_list/data/repositories/in_memory_user_repository.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

import '../../user_list/fake_user_repository.dart';

void main() {
  Widget consumerWidgetApp({
    FakeUserRepository repository = const FakeUserRepository(
      users: [
        User(id: 10, username: 'Grace', age: 85, email: 'grace@example.com'),
      ],
    ),
  }) {
    return ProviderScope(
      overrides: [userRepositoryProvider.overrideWithValue(repository)],
      child: MaterialApp(
        locale: const Locale('en'),
        theme: getLightTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const ConsumerWidgetScreen(),
      ),
    );
  }

  testWidgets('shows the same users in both panels', (tester) async {
    await tester.pumpWidget(consumerWidgetApp());
    await tester.pumpAndSettle();

    expect(find.text('StatelessWidget + Consumer'), findsOneWidget);
    expect(find.text('ConsumerWidget'), findsOneWidget);
    expect(find.text('User: Grace'), findsNWidgets(2));
  });

  testWidgets('adding a demo user updates both panels', (tester) async {
    await tester.pumpWidget(consumerWidgetApp());
    await tester.pumpAndSettle();

    await tester.ensureVisible(
      find.widgetWithText(FullWidthElevatedButton, 'Add demo user').first,
    );
    await tester.tap(
      find.widgetWithText(FullWidthElevatedButton, 'Add demo user').first,
    );
    await tester.pumpAndSettle();

    expect(find.text('User: Demo 11'), findsNWidgets(2));
  });
}
