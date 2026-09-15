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
    FakeCourseLabRepository repository = const FakeCourseLabRepository(
      courses: [sampleCourse, sampleAdvancedCourse, sampleExpertCourse],
    ),
  }) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
          courseLabRepositoryProvider.overrideWithValue(repository),
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

  testWidgets('lists catalog cards with placeholder, copy, and track', (
    tester,
  ) async {
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
}
