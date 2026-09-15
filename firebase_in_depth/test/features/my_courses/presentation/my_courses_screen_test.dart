import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/core/theme/theme.dart';
import 'package:firebase_in_depth/features/auth/presentation/providers/auth_provider.dart';
import 'package:firebase_in_depth/features/course_lab/data/repositories/course_lab_repository_impl.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/data/repositories/firebase_fundamentals_repository_impl.dart';
import 'package:firebase_in_depth/features/my_courses/presentation/my_courses_screen.dart';
import 'package:firebase_in_depth/features/my_courses/presentation/widgets/my_course_card.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:firebase_in_depth/shared_widgets/app_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../auth/fake_auth_repository.dart';
import '../../course_lab/course_fixtures.dart';
import '../../course_lab/fake_course_lab_repository.dart';
import '../../firebase_fundamentals/fake_firebase_fundamentals_repository.dart';

void main() {
  Future<void> pump(
    WidgetTester tester, {
    FakeCourseLabRepository? repository,
    String? email,
  }) async {
    final auth = FakeAuthRepository();
    if (email != null) {
      await auth.signIn(email: email, password: 'secret');
    }
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(auth),
          courseLabRepositoryProvider.overrideWithValue(
            repository ??
                const FakeCourseLabRepository(
                  courses: [
                    sampleCourse,
                    sampleAdvancedCourse,
                    sampleExpertCourse,
                  ],
                ),
          ),
          firebaseFundamentalsRepositoryProvider.overrideWithValue(
            const FakeFirebaseFundamentalsRepository(),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          theme: getLightTheme(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const MyCoursesScreen(),
        ),
      ),
    );
  }

  testWidgets('lists catalog cards in beginner and advanced columns', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pump(tester);
    await tester.pumpAndSettle();

    expect(find.text('My Courses'), findsOneWidget);
    expect(find.byType(AppBackground), findsOneWidget);
    expect(find.byType(MyCourseCard), findsNWidgets(3));
    expect(
      find.byKey(const Key('my-course-card-hiragana-from-zero')),
      findsOneWidget,
    );
    expect(find.text('Hiragana from Zero'), findsOneWidget);
    expect(find.text('Learn the 46 hiragana.'), findsOneWidget);
    expect(find.text('Beginner course'), findsOneWidget);
    expect(find.text('Keigo Essentials'), findsOneWidget);
    expect(find.text('Honorifics for work.'), findsOneWidget);
    expect(find.text('Advanced course'), findsOneWidget);
    expect(find.text('Newspaper Japanese'), findsOneWidget);
    expect(find.text('Expert course'), findsOneWidget);
    expect(
      find.image(const AssetImage(MyCourseCard.videoPlaceholderAsset)),
      findsNWidgets(3),
    );
    expect(find.byKey(const Key('my-courses-create')), findsNothing);
    expect(find.text('Edit'), findsNothing);
    expect(
      find.byKey(const Key('my-course-delete-hiragana-from-zero')),
      findsNothing,
    );

    final beginner = tester.getRect(
      find.byKey(const Key('my-courses-column-beginner')),
    );
    final advanced = tester.getRect(
      find.byKey(const Key('my-courses-column-advanced')),
    );
    expect(beginner.left, lessThan(advanced.left));
  });

  testWidgets('shows an empty library message', (tester) async {
    await pump(tester, repository: const FakeCourseLabRepository());
    await tester.pumpAndSettle();

    expect(find.text('No courses in your library yet.'), findsOneWidget);
    expect(find.byType(MyCourseCard), findsNothing);
  });

  testWidgets('shows a retryable load error', (tester) async {
    await pump(
      tester,
      repository: const FakeCourseLabRepository(error: NetworkFailure()),
    );
    await tester.pumpAndSettle();

    expect(
      find.text("Couldn't load courses. Try again later."),
      findsOneWidget,
    );
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('tutors can delete a course from Firestore via the catalog', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final repository = FakeCourseLabRepository(
      courses: List.of([
        sampleCourse,
        sampleAdvancedCourse,
        sampleExpertCourse,
      ]),
    );
    await pump(tester, repository: repository, email: 'tutor@lab.dev');
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('my-courses-create')), findsOneWidget);
    expect(find.text('Edit'), findsNWidgets(3));

    await tester.tap(find.byKey(const Key('my-courses-create')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('my-courses-create-dialog')), findsOneWidget);
    await tester.tap(find.byKey(const Key('my-courses-create-cancel')));
    await tester.pumpAndSettle();
    expect(find.byType(MyCourseCard), findsNWidgets(3));

    await tester.tap(
      find.byKey(const Key('my-course-delete-hiragana-from-zero')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Hiragana from Zero'), findsNothing);
    expect(find.byType(MyCourseCard), findsNWidgets(2));
    expect(repository.courses, [sampleAdvancedCourse, sampleExpertCourse]);
  });

  testWidgets('a blocked delete keeps the card and shows the rules error', (
    tester,
  ) async {
    await pump(
      tester,
      repository: const FakeCourseLabRepository(
        courses: [sampleCourse],
        deleteError: PermissionFailure(),
      ),
      email: 'tutor@lab.dev',
    );
    await tester.pumpAndSettle();

    await tester.tap(
      find.byKey(const Key('my-course-delete-hiragana-from-zero')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Hiragana from Zero'), findsOneWidget);
    expect(
      find.text(
        'Permission denied. Firestore rules blocked this read or write.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('students do not get tutor actions', (tester) async {
    await pump(tester, email: 'noir@lab.dev');
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('my-courses-create')), findsNothing);
    expect(find.text('Edit'), findsNothing);
    expect(
      find.byKey(const Key('my-course-delete-hiragana-from-zero')),
      findsNothing,
    );
  });

  testWidgets('tutors create a catalog document from the plus button', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final repository = FakeCourseLabRepository(
      courses: List.of([sampleCourse]),
    );
    await pump(tester, repository: repository, email: 'tutor@lab.dev');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('my-courses-create')));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('my-courses-create-description')),
      'Night School',
    );
    await tester.enterText(
      find.byKey(const Key('my-courses-create-long-description')),
      'Evenings only.',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('my-courses-create-save')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('my-courses-create-dialog')), findsNothing);
    expect(find.text('Night School'), findsOneWidget);
    expect(find.text('Evenings only.'), findsOneWidget);
    expect(repository.courses.last.description, 'Night School');
    expect(repository.courses.last.id, 'night-school');
    expect(repository.courses.last.categories, ['BEGINNER']);
  });
}
