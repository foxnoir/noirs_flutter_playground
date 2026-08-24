import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/scenarios/current_user/presentation/current_user_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

void main() {
  testWidgets('CurrentUserScreen shows the dummy form and empty add handler', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: CurrentUserScreen(),
      ),
    );

    expect(find.text('Current User'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Username'), findsOneWidget);
    expect(find.text('Add User'), findsOneWidget);
    expect(find.byType(FullWidthElevatedButton), findsOneWidget);
    expect(find.text('User: —'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Ada');
    await tester.tap(find.text('Add User'));
    await tester.pump();

    expect(find.text('User: —'), findsOneWidget);
    expect(find.text('Ada'), findsOneWidget);
  });
}
