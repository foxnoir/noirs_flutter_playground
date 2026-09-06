import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/data/repositories/firebase_fundamentals_repository.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/firebase_fundamentals_screen.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../course_fixtures.dart';
import '../fake_firebase_fundamentals_repository.dart';

void main() {
  testWidgets('reads a document from the repository', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          firebaseFundamentalsRepositoryProvider.overrideWithValue(
            const FakeFirebaseFundamentalsRepository(course: sampleCourse),
          ),
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: FirebaseFundamentalsScreen(),
        ),
      ),
    );

    expect(find.text('Firebase Fundamentals'), findsOneWidget);
    await tester.tap(find.byKey(const Key('fundamentals-read-document')));
    await tester.pumpAndSettle();

    expect(find.text('Hiragana from Zero'), findsOneWidget);
  });

  testWidgets('shows the Firestore error for the invalid query', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          firebaseFundamentalsRepositoryProvider.overrideWithValue(
            const FakeFirebaseFundamentalsRepository(
              invalidQueryError: InvalidQueryFailure(
                detail: 'two inequalities',
              ),
            ),
          ),
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: FirebaseFundamentalsScreen(),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('fundamentals-invalid-query')));
    await tester.pumpAndSettle();

    expect(find.text('two inequalities'), findsOneWidget);
  });

  testWidgets('shows the missing-index error including the message', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          firebaseFundamentalsRepositoryProvider.overrideWithValue(
            const FakeFirebaseFundamentalsRepository(
              missingIndexError: InvalidQueryFailure(
                detail:
                    'The query requires an index. You can create it here: https://console.firebase.google.com/example',
              ),
            ),
          ),
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: FirebaseFundamentalsScreen(),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('fundamentals-missing-index-query')));
    await tester.pumpAndSettle();

    expect(find.textContaining('The query requires an index.'), findsOneWidget);
    expect(
      find.textContaining('https://console.firebase.google.com/example'),
      findsOneWidget,
    );
  });
}
