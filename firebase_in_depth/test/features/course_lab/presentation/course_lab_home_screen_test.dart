import 'package:firebase_in_depth/core/router/page_not_found_screen.dart';
import 'package:firebase_in_depth/features/course_lab/data/repositories/course_lab_repository_impl.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/course_lab_home_screen.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/widgets/course_lab_track_links.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/widgets/course_lab_track_panel.dart';
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
              courses: [sampleCourse, sampleAdvancedCourse],
            ),
          ),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: home,
        ),
      ),
    );
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

  testWidgets('Home lists beginner courses and slides to advanced', (
    tester,
  ) async {
    await pump(tester, const CourseLabHomeScreen());
    await tester.pumpAndSettle();

    expect(find.text('Start with the kana.'), findsOneWidget);
    expect(find.text('Hiragana from Zero'), findsOneWidget);
    expect(find.byKey(const Key('schedule-dragon-beginner')), findsOneWidget);

    final beginnerPanel = tester.getRect(
      find.byType(CourseLabTrackPanel).first,
    );
    final beginnerDragon = tester.getRect(
      find.byKey(const Key('schedule-dragon-beginner')),
    );
    expect(beginnerDragon.center.dx, greaterThan(beginnerPanel.center.dx));
    expect(beginnerDragon.center.dy, greaterThan(beginnerPanel.center.dy));

    final beginner = tester.getRect(find.text('Beginner course'));
    final advanced = tester.getRect(find.text('Advanced course'));
    final links = tester.getRect(find.byType(CourseLabTrackLinks));
    expect(beginner.center.dx, lessThan(links.center.dx));
    expect(advanced.center.dx, greaterThan(links.center.dx));
    expect(beginner.left, greaterThan(links.left));
    expect(advanced.right, lessThan(links.right));
    expect(find.text('Keigo Essentials').hitTestable(), findsNothing);

    await tester.tap(find.text('Advanced course'));
    await tester.pumpAndSettle();

    expect(
      find.text('Keigo, kanji, and nuance.').hitTestable(),
      findsOneWidget,
    );
    expect(find.text('Keigo Essentials').hitTestable(), findsOneWidget);
    expect(find.text('Hiragana from Zero').hitTestable(), findsNothing);

    final advancedPanel = tester.getRect(find.byType(CourseLabTrackPanel).last);
    final advancedDragon = tester.getRect(
      find.byKey(const Key('schedule-dragon-advanced')),
    );
    expect(advancedDragon.center.dx, lessThan(advancedPanel.center.dx));
    expect(advancedDragon.center.dy, greaterThan(advancedPanel.center.dy));
  });
}
