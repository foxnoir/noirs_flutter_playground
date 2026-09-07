import 'package:firebase_in_depth/features/course_lab/presentation/course_lab_home_screen.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/firebase_fundamentals_screen.dart';
import 'package:firebase_in_depth/features/landing/presentation/landing_screen.dart';
import 'package:firebase_in_depth/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Landing is the initial route and lists both labs', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: FirebaseInDepthApp()));

    expect(find.byType(LandingScreen), findsOneWidget);
    expect(find.text('Firebase Course Lab'), findsOneWidget);
    expect(find.text('Firebase Fundamentals'), findsOneWidget);
    expect(find.text('Lab'), findsOneWidget);

    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pump();

    final fundamentals = tester.getTopLeft(
      find.byKey(const Key('landing-fundamentals')),
    );
    final courseLab = tester.getTopLeft(
      find.byKey(const Key('landing-course-lab')),
    );
    expect(courseLab.dx, greaterThan(fundamentals.dx));
  });

  testWidgets('Landing navigates to Course Lab Home', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FirebaseInDepthApp()));

    await tester.tap(find.text('Firebase Course Lab'));
    await tester.pumpAndSettle();

    expect(find.byType(CourseLabHomeScreen), findsOneWidget);
    expect(find.text('Home'), findsWidgets);
    expect(find.text('Beginner course'), findsOneWidget);
    expect(find.text('Start with the kana.'), findsOneWidget);
  });

  testWidgets('Home swaps beginner and advanced panels', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FirebaseInDepthApp()));

    await tester.tap(find.text('Firebase Course Lab'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Advanced course'));
    await tester.pumpAndSettle();

    final pages = tester.widget<PageView>(find.byType(PageView));
    expect(pages.controller?.page, closeTo(1, 0.01));
    expect(
      find.text('Keigo, kanji, and nuance.').hitTestable(),
      findsOneWidget,
    );

    await tester.tap(find.text('Beginner course'));
    await tester.pumpAndSettle();

    expect(pages.controller?.page, closeTo(0, 0.01));
    expect(find.text('Start with the kana.').hitTestable(), findsOneWidget);
  });

  testWidgets('Landing navigates to Firebase Fundamentals', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FirebaseInDepthApp()));

    await tester.tap(find.text('Firebase Fundamentals'));
    await tester.pumpAndSettle();

    expect(find.byType(FirebaseFundamentalsScreen), findsOneWidget);
  });
}
