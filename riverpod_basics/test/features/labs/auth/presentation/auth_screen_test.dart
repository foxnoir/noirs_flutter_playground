import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/auth_screen.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/widgets/auth_protected.dart';
import 'package:riverpod_basics/main.dart';

void main() {
  Finder authKey(Key key) => find.byKey(key).last;

  Future<void> openAuthLab(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Labs'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Auth'), 80);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Auth'));
    await tester.pumpAndSettle();
  }

  Future<void> revealOnAuth(WidgetTester tester, Key key) async {
    await tester.ensureVisible(authKey(key));
    await tester.pump();
  }

  ElevatedButton buttonOf(Key key, WidgetTester tester) {
    return tester.widget<ElevatedButton>(
      find.descendant(
        of: authKey(key),
        matching: find.byType(ElevatedButton),
      ),
    );
  }

  testWidgets('Protected while signed out redirects to Auth with from', (
    tester,
  ) async {
    await openAuthLab(tester);

    await revealOnAuth(tester, const Key('protected'));
    await tester.tap(authKey(const Key('protected')));
    await tester.pump();
    await tester.pump();

    expect(find.byType(AuthScreen), findsAtLeastNWidgets(1));
    expect(find.byType(AuthProtected), findsNothing);
    expect(find.byKey(const Key('unauthorized')), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(SnackBar),
        matching: find.text('goNamed() → redirect()'),
      ),
      findsAtLeastNWidgets(1),
    );

    await revealOnAuth(tester, const Key('submit'));
    await tester.enterText(authKey(const Key('username')), 'a');
    await tester.enterText(authKey(const Key('password')), 'b');
    await tester.tap(authKey(const Key('submit')));
    await tester.pump();
    await tester.pump();
    await tester.pump();

    expect(find.byType(AuthProtected), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(SnackBar),
        matching: find.text('redirect()'),
      ),
      findsAtLeastNWidgets(1),
    );
  });

  testWidgets('Sign in without from stays on Auth', (tester) async {
    await openAuthLab(tester);

    expect(find.byKey(const Key('unauthorized')), findsNothing);

    await revealOnAuth(tester, const Key('submit'));
    await tester.enterText(authKey(const Key('username')), 'a');
    await tester.enterText(authKey(const Key('password')), 'b');
    await tester.tap(authKey(const Key('submit')));
    await tester.pump();
    await tester.pump();

    expect(find.byType(AuthScreen), findsOneWidget);
    expect(find.byKey(const Key('sign-out')), findsOneWidget);
    expect(buttonOf(const Key('sign-out'), tester).onPressed, isNotNull);

    await revealOnAuth(tester, const Key('protected'));
    await tester.tap(authKey(const Key('protected')));
    await tester.pumpAndSettle();

    expect(find.byType(AuthProtected), findsOneWidget);
  });
}
