import 'package:firebase_in_depth/core/router/page_not_found_screen.dart';
import 'package:firebase_in_depth/core/theme/theme.dart';
import 'package:firebase_in_depth/features/course_lab/data/repositories/course_lab_repository_impl.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/course_lab_home_screen.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/widgets/course_lab_track_links.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/firebase_fundamentals_screen.dart';
import 'package:firebase_in_depth/features/landing/presentation/landing_screen.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:firebase_in_depth/shared_widgets/app_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../course_fixtures.dart';
import '../fake_course_lab_repository.dart';

void main() {
  Future<void> pump(WidgetTester tester, Widget home) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [
          courseLabRepositoryProvider.overrideWithValue(
            const FakeCourseLabRepository(
              courses: [sampleCourse, sampleAdvancedCourse, sampleExpertCourse],
            ),
          ),
        ],
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

  testWidgets('every SiteScaffold page uses bg.webp', (tester) async {
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
      find.text('Keigo, kanji, and nuance.').hitTestable(),
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
        'Keigo, kanji compounds, and the courses '
        'that assume you already read kana.',
      ),
    );
    expect(advancedList.top - advancedBody.bottom, lessThan(40));

    await tester.tap(find.text('Expert course'));
    await tester.pumpAndSettle();

    expect(find.text('Past the textbook.').hitTestable(), findsOneWidget);
    expect(find.text('Newspaper Japanese').hitTestable(), findsOneWidget);
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
}
