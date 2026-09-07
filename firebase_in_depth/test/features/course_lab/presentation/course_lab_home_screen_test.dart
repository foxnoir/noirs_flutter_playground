import 'package:firebase_in_depth/core/router/page_not_found_screen.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/course_lab_home_screen.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/firebase_fundamentals_screen.dart';
import 'package:firebase_in_depth/features/landing/presentation/landing_screen.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:firebase_in_depth/shared_widgets/app_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pump(WidgetTester tester, Widget home) {
    return tester.pumpWidget(
      ProviderScope(
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
}
