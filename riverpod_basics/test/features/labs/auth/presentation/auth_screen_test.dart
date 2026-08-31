import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/auth_login_screen.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/auth_next_screen.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/auth_screen.dart';
import 'package:riverpod_basics/main.dart';

void main() {
  Future<void> openAuthLab(WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Labs'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Auth'), 80);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Auth'));
    await tester.pumpAndSettle();
  }

  ElevatedButton buttonOf(Key key, WidgetTester tester) {
    return tester.widget<ElevatedButton>(
      find.descendant(
        of: find.byKey(key),
        matching: find.byType(ElevatedButton),
      ),
    );
  }

  testWidgets('Next Screen while logged out redirects to login with from', (
    tester,
  ) async {
    await openAuthLab(tester);

    await tester.tap(find.byKey(const Key('authNext')));
    await tester.pump();
    await tester.pump();

    expect(find.byType(AuthLoginScreen), findsOneWidget);
    expect(find.byType(AuthNextScreen), findsNothing);
    expect(find.byKey(const Key('authUnauthorized')), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(SnackBar),
        matching: find.text('goNamed() → redirect()'),
      ),
      findsAtLeastNWidgets(1),
    );

    await tester.tap(find.byKey(const Key('authSubmit')));
    await tester.pump();
    await tester.pump();

    expect(find.byType(AuthNextScreen), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(SnackBar),
        matching: find.text('redirect()'),
      ),
      findsAtLeastNWidgets(1),
    );
  });

  testWidgets('Log in without from returns to the hub', (tester) async {
    await openAuthLab(tester);

    await tester.tap(find.byKey(const Key('authLogin')));
    await tester.pump();
    await tester.pump();
    expect(find.byType(AuthLoginScreen), findsOneWidget);
    expect(find.byKey(const Key('authUnauthorized')), findsNothing);
    expect(
      find.descendant(
        of: find.byType(SnackBar),
        matching: find.text('goNamed()'),
      ),
      findsAtLeastNWidgets(1),
    );

    await tester.enterText(find.byKey(const Key('authUsername')), 'a');
    await tester.enterText(find.byKey(const Key('authPassword')), 'b');
    await tester.tap(find.byKey(const Key('authSubmit')));
    await tester.pump();
    await tester.pump();

    expect(find.byType(AuthScreen), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(SnackBar),
        matching: find.text('redirect()'),
      ),
      findsAtLeastNWidgets(1),
    );
    expect(buttonOf(const Key('authLogin'), tester).onPressed, isNull);
    expect(buttonOf(const Key('authLogout'), tester).onPressed, isNotNull);

    await tester.tap(find.byKey(const Key('authNext')));
    await tester.pumpAndSettle();

    expect(find.byType(AuthNextScreen), findsOneWidget);
  });
}
