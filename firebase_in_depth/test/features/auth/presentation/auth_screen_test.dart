import 'package:firebase_in_depth/features/auth/presentation/auth_screen.dart';
import 'package:firebase_in_depth/features/auth/presentation/providers/auth_provider.dart';
import 'package:firebase_in_depth/features/course_lab/data/repositories/course_lab_repository_impl.dart';
import 'package:firebase_in_depth/features/landing/presentation/landing_screen.dart';
import 'package:firebase_in_depth/main.dart';
import 'package:firebase_in_depth/shared_widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../course_lab/course_fixtures.dart';
import '../../course_lab/fake_course_lab_repository.dart';
import '../fake_auth_repository.dart';

void main() {
  Widget app() {
    return ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        courseLabRepositoryProvider.overrideWithValue(
          const FakeCourseLabRepository(
            courses: [sampleCourse, sampleAdvancedCourse, sampleExpertCourse],
          ),
        ),
      ],
      child: const FirebaseInDepthApp(),
    );
  }

  testWidgets('header has one Sign in / Sign up button to the right of Lab', (
    tester,
  ) async {
    await tester.pumpWidget(app());

    expect(find.byType(LandingScreen), findsOneWidget);
    expect(find.byKey(const Key('header-auth')), findsOneWidget);
    expect(find.text('Sign in / Sign up'), findsOneWidget);
    expect(find.byKey(const Key('header-account')), findsNothing);

    final lab = tester.getRect(find.text('Lab'));
    final auth = tester.getRect(find.byKey(const Key('header-auth')));
    expect(auth.left, greaterThan(lab.right));
  });

  testWidgets('Sign in / Sign up opens the sign-in card', (tester) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(app());

    await tester.tap(find.byKey(const Key('header-auth')));
    await tester.pumpAndSettle();

    expect(find.byType(AuthScreen), findsOneWidget);
    expect(find.byKey(const Key('auth-card')), findsOneWidget);
    expect(find.byKey(const Key('auth-panel')), findsOneWidget);
    expect(find.byKey(const Key('auth-email')), findsOneWidget);
    expect(find.byKey(const Key('auth-password')), findsOneWidget);
    expect(find.byKey(const Key('header-auth')), findsNothing);
    expect(find.text('Create an account'), findsOneWidget);
    expect(find.text('Forgot password?'), findsOneWidget);
    expect(find.widgetWithText(GradientButton, 'Sign in'), findsOneWidget);

    final panel = tester.getRect(find.byKey(const Key('auth-panel')));
    final frame = tester.getRect(find.byKey(const Key('auth-panel-frame')));
    final card = tester.getRect(find.byKey(const Key('auth-card')));
    final email = tester.getRect(find.byKey(const Key('auth-email')));
    final submit = tester.getRect(find.byKey(const Key('auth-submit')));
    expect(panel.left, lessThan(email.left));
    expect(email.left, greaterThan(panel.right - 8));
    expect(frame.height, greaterThan(card.height));
    expect(frame.width, greaterThan(card.width));
    expect(submit.width, moreOrLessEquals(email.width, epsilon: 4));

    final create = tester.getRect(find.text('Create an account'));
    final forgot = tester.getRect(find.text('Forgot password?'));
    expect(create.left, moreOrLessEquals(email.left, epsilon: 12));
    expect(forgot.right, moreOrLessEquals(email.right, epsilon: 12));
  });

  testWidgets('sign up swaps the panel to the right of the form', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(app());

    await tester.tap(find.byKey(const Key('header-auth')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('auth-switch-mode')));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(GradientButton, 'Sign up'), findsOneWidget);
    expect(find.text('Already have an account?'), findsOneWidget);
    expect(find.byKey(const Key('auth-username')), findsOneWidget);
    expect(find.text('Create an account'), findsNothing);

    final panel = tester.getRect(find.byKey(const Key('auth-panel')));
    final frame = tester.getRect(find.byKey(const Key('auth-panel-frame')));
    final card = tester.getRect(find.byKey(const Key('auth-card')));
    final email = tester.getRect(find.byKey(const Key('auth-email')));
    final submit = tester.getRect(find.byKey(const Key('auth-submit')));
    expect(email.left, lessThan(panel.left));
    expect(email.right, lessThan(panel.left + 8));
    expect(frame.height, greaterThan(card.height));
    expect(frame.width, greaterThan(card.width));
    expect(submit.width, moreOrLessEquals(email.width, epsilon: 4));

    final haveAccount = tester.getRect(find.text('Already have an account?'));
    expect(haveAccount.right, moreOrLessEquals(email.right, epsilon: 12));

    await tester.tap(find.byKey(const Key('auth-switch-mode')));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(GradientButton, 'Sign in'), findsOneWidget);
    expect(find.text('Create an account'), findsOneWidget);
  });

  testWidgets('sign up then account menu can sign out', (tester) async {
    await tester.pumpWidget(app());

    await tester.tap(find.byKey(const Key('header-auth')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('auth-switch-mode')));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('auth-email')), 'new@lab.dev');
    await tester.enterText(find.byKey(const Key('auth-password')), 'secret');
    await tester.tap(find.byKey(const Key('auth-submit')));
    await tester.pumpAndSettle();

    expect(find.byType(LandingScreen), findsOneWidget);
    expect(find.byKey(const Key('header-account')), findsOneWidget);
    expect(
      find.image(const AssetImage('assets/icons/categories/beginner.png')),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('header-account')));
    await tester.pumpAndSettle();

    expect(find.text('new@lab.dev'), findsOneWidget);
    expect(find.text('Student'), findsOneWidget);
  });

  testWidgets('login then account menu can sign out', (tester) async {
    await tester.pumpWidget(app());

    await tester.tap(find.byKey(const Key('header-auth')));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('auth-email')), 'noir@lab.dev');
    await tester.enterText(find.byKey(const Key('auth-password')), 'secret');
    await tester.tap(find.byKey(const Key('auth-submit')));
    await tester.pumpAndSettle();

    expect(find.byType(LandingScreen), findsOneWidget);
    expect(find.byKey(const Key('header-auth')), findsNothing);
    expect(find.byKey(const Key('header-account')), findsOneWidget);

    await tester.tap(find.byKey(const Key('header-account')));
    await tester.pumpAndSettle();

    expect(find.text('noir@lab.dev'), findsOneWidget);
    expect(find.text('Student'), findsOneWidget);

    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('header-auth')), findsOneWidget);
    expect(find.byKey(const Key('header-account')), findsNothing);
  });

  testWidgets('tutor@lab.dev shows Tutor in the account menu', (tester) async {
    await tester.pumpWidget(app());

    await tester.tap(find.byKey(const Key('header-auth')));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('auth-email')),
      'tutor@lab.dev',
    );
    await tester.enterText(find.byKey(const Key('auth-password')), 'secret');
    await tester.tap(find.byKey(const Key('auth-submit')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('header-account')));
    await tester.pumpAndSettle();

    expect(find.text('Tutor'), findsOneWidget);
    expect(find.text('Student'), findsNothing);
    expect(
      find.image(const AssetImage('assets/icons/categories/advanced.png')),
      findsOneWidget,
    );
  });
}
