import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/core/router/page_not_found_screen.dart';
import 'package:firebase_in_depth/core/theme/theme.dart';
import 'package:firebase_in_depth/features/course_lab/data/repositories/course_lab_repository_impl.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/course_lab_home_screen.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/widgets/course_lab_track_links.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/firebase_fundamentals_screen.dart';
import 'package:firebase_in_depth/features/landing/presentation/landing_screen.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:firebase_in_depth/shared_widgets/app_background.dart';
import 'package:firebase_in_depth/shared_widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../course_fixtures.dart';
import '../fake_course_lab_repository.dart';

void main() {
  Future<void> pump(
    WidgetTester tester,
    Widget home, {
    FakeCourseLabRepository repository = const FakeCourseLabRepository(
      courses: [sampleCourse, sampleAdvancedCourse, sampleExpertCourse],
    ),
  }) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [courseLabRepositoryProvider.overrideWithValue(repository)],
        child: MaterialApp(
          locale: const Locale('en'),
          theme: getLightTheme(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: home,
        ),
      ),
    );
  }

  Finder panel(CourseLabTrack track) {
    return find.byKey(Key('course-lab-panel-${track.name}'));
  }

  testWidgets('every DesktopScaffold page uses bg.webp', (tester) async {
    for (final home in const [
      LandingScreen(),
      CourseLabHomeScreen(),
      FirebaseFundamentalsScreen(),
      PageNotFoundScreen(),
    ]) {
      await pump(tester, home);
      await tester.pump();
      expect(find.byType(AppBackground), findsOneWidget);
    }
    expect(AppBackground.asset, 'assets/img/bg.webp');
  });

  testWidgets('Home lists beginner courses and slides tracks', (tester) async {
    await pump(tester, const CourseLabHomeScreen());
    await tester.pumpAndSettle();

    expect(find.text('Start with the kana.'), findsOneWidget);
    expect(find.text('Hiragana from Zero'), findsOneWidget);
    expect(find.byKey(const Key('schedule-dragon-beginner')), findsOneWidget);
    expect(find.byKey(const Key('no-courses-dragon-beginner')), findsNothing);
    expect(find.byKey(const Key('course-lab-icon-beginner')), findsOneWidget);
    expect(
      tester.widget<Text>(find.text('Beginner course')).style?.color,
      AppColor.secondary,
    );

    final beginnerPanel = tester.getRect(panel(CourseLabTrack.beginner));
    final beginnerDragon = tester.getRect(
      find.byKey(const Key('schedule-dragon-beginner')),
    );
    expect(beginnerDragon.center.dx, greaterThan(beginnerPanel.center.dx));
    expect(beginnerDragon.center.dy, greaterThan(beginnerPanel.center.dy));

    final beginner = tester.getRect(find.text('Beginner course'));
    final advanced = tester.getRect(find.text('Advanced course'));
    final expert = tester.getRect(find.text('Expert course'));
    final links = tester.getRect(find.byType(CourseLabTrackLinks));
    expect(beginner.center.dx, lessThan(advanced.center.dx));
    expect(advanced.center.dx, lessThan(expert.center.dx));
    expect(beginner.left, greaterThan(links.left));
    expect(expert.right, lessThan(links.right));
    expect(find.text('Keigo Essentials').hitTestable(), findsNothing);

    await tester.tap(find.text('Advanced course'));
    await tester.pumpAndSettle();

    expect(
      find.text('Polite speech, counters, and more.').hitTestable(),
      findsOneWidget,
    );
    expect(find.text('Keigo Essentials').hitTestable(), findsOneWidget);
    expect(find.text('Hiragana from Zero').hitTestable(), findsNothing);
    expect(find.byKey(const Key('schedule-dragon-advanced')), findsNothing);
    expect(
      tester.widget<Text>(find.text('Advanced course')).style?.color,
      AppColor.primaryContainer,
    );

    final advancedPanel = tester.getRect(panel(CourseLabTrack.advanced));
    final advancedList = tester.getRect(
      find.byKey(const Key('course-lab-list-advanced')),
    );
    expect(advancedList.width, lessThan(advancedPanel.width * 0.7));
    expect(
      (advancedList.center.dx - advancedPanel.center.dx).abs(),
      lessThan(24),
    );
    final advancedBody = tester.getRect(
      find.text(
        'Polite language for work, counting things, and the sound words '
        'textbooks mention once. Kana is assumed.',
      ),
    );
    expect(advancedList.top - advancedBody.bottom, lessThan(40));

    await tester.tap(find.text('Expert course'));
    await tester.pumpAndSettle();

    expect(find.text('Past the textbook.').hitTestable(), findsOneWidget);
    expect(find.text('Newspaper Japanese').hitTestable(), findsOneWidget);
    final expertTitle = tester.getRect(find.text('Newspaper Japanese'));
    final expertTile = find.widgetWithText(ListTile, 'Newspaper Japanese');
    final expertIcon = tester.getRect(
      find.descendant(of: expertTile, matching: find.byType(Image)),
    );
    expect(expertIcon.center.dx, greaterThan(expertTitle.center.dx));
    expect(
      tester.widget<Text>(find.text('Expert course')).style?.color,
      AppColor.purple,
    );

    final expertPanel = tester.getRect(panel(CourseLabTrack.expert));
    final expertDragon = tester.getRect(
      find.byKey(const Key('schedule-dragon-expert')),
    );
    expect(expertDragon.center.dx, lessThan(expertPanel.center.dx));
    expect(expertDragon.center.dy, greaterThan(expertPanel.center.dy));
  });

  testWidgets('empty track is a catalog message, not a query miss', (
    tester,
  ) async {
    await pump(
      tester,
      const CourseLabHomeScreen(),
      repository: const FakeCourseLabRepository(),
    );
    await tester.pumpAndSettle();

    expect(find.text('No courses in this track yet.'), findsOneWidget);
    expect(find.text('No documents matched.'), findsNothing);
    expect(find.byKey(const Key('schedule-dragon-beginner')), findsNothing);
    expect(find.byKey(const Key('no-courses-dragon-beginner')), findsOneWidget);

    final beginnerPanel = tester.getRect(panel(CourseLabTrack.beginner));
    final emptyDragon = tester.getRect(
      find.byKey(const Key('no-courses-dragon-beginner')),
    );
    expect(emptyDragon.center.dx, greaterThan(beginnerPanel.center.dx));
    expect(emptyDragon.center.dy, greaterThan(beginnerPanel.center.dy));
  });

  testWidgets('unreachable service names the courses and offers retry', (
    tester,
  ) async {
    await pump(
      tester,
      const CourseLabHomeScreen(),
      repository: const FakeCourseLabRepository(error: NetworkFailure()),
    );
    await tester.pumpAndSettle();

    expect(
      find.text("Couldn't load courses. Try again later."),
      findsOneWidget,
    );
    expect(find.text('Retry'), findsOneWidget);
    expect(find.byType(GradientButton), findsOneWidget);
    expect(find.byType(TextButton), findsNothing);

    final errorText = tester.getRect(
      find.text("Couldn't load courses. Try again later."),
    );
    final retry = tester.getRect(find.byType(GradientButton));
    expect(retry.left, closeTo(errorText.left, 8));
    expect(retry.top - errorText.bottom, greaterThan(12));
    expect(retry.top - errorText.bottom, lessThan(32));
    expect(find.text('The backend is not running.'), findsNothing);
    expect(
      find.text('Could not reach the server. Check your connection.'),
      findsNothing,
    );
    expect(find.text('No documents matched.'), findsNothing);
    expect(find.text('No courses in this track yet.'), findsNothing);
    expect(find.byKey(const Key('schedule-dragon-beginner')), findsNothing);
    expect(find.byKey(const Key('no-courses-dragon-beginner')), findsOneWidget);

    await tester.tap(find.text('Advanced course'));
    await tester.pumpAndSettle();

    final advancedError = tester.getRect(
      find.text("Couldn't load courses. Try again later.").hitTestable(),
    );
    final advancedRetry = tester.getRect(
      find.byType(GradientButton).hitTestable(),
    );
    final advancedPanel = tester.getRect(panel(CourseLabTrack.advanced));
    expect(
      (advancedRetry.center.dx - advancedPanel.center.dx).abs(),
      lessThan(24),
    );
    expect(advancedRetry.top - advancedError.bottom, greaterThan(12));
    expect(advancedRetry.top - advancedError.bottom, lessThan(32));
    expect(find.byKey(const Key('no-courses-dragon-advanced')), findsOneWidget);
    final advancedDragon = tester.widget<Image>(
      find.byKey(const Key('no-courses-dragon-advanced')),
    );
    expect(
      (advancedDragon.image as AssetImage).assetName,
      'assets/img/no_courses_advanced_dragon.png',
    );

    await tester.tap(find.text('Expert course'));
    await tester.pumpAndSettle();

    final expertError = tester.getRect(
      find.text("Couldn't load courses. Try again later.").hitTestable(),
    );
    final expertRetry = tester.getRect(
      find.byType(GradientButton).hitTestable(),
    );
    expect(expertRetry.right, closeTo(expertError.right, 8));
    expect(expertRetry.top - expertError.bottom, greaterThan(12));
    expect(expertRetry.top - expertError.bottom, lessThan(32));
  });
}
