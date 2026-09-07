import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/data/repositories/firebase_fundamentals_repository_impl.dart';
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

  testWidgets('places reads and queries in two columns when wide', (
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
            const FakeFirebaseFundamentalsRepository(),
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

    final collection = tester.getTopLeft(
      find.byKey(const Key('fundamentals-read-collection')),
    );
    final document = tester.getTopLeft(
      find.byKey(const Key('fundamentals-read-document')),
    );
    expect(document.dx, greaterThan(collection.dx));
    expect(document.dy, closeTo(collection.dy, 1));

    final valid = tester.getTopLeft(
      find.byKey(const Key('fundamentals-valid-query')),
    );
    final composite = tester.getTopLeft(
      find.byKey(const Key('fundamentals-composite-query')),
    );
    final invalid = tester.getTopLeft(
      find.byKey(const Key('fundamentals-invalid-query')),
    );
    final missing = tester.getTopLeft(
      find.byKey(const Key('fundamentals-missing-index-query')),
    );
    expect(invalid.dx, greaterThan(valid.dx));
    expect(composite.dx, closeTo(valid.dx, 1));
    expect(composite.dy, greaterThan(valid.dy));
    expect(missing.dx, closeTo(invalid.dx, 1));
    expect(missing.dy, greaterThan(invalid.dy));
  });

  testWidgets('stacks reads when compact', (tester) async {
    tester.view.physicalSize = const Size(400, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          firebaseFundamentalsRepositoryProvider.overrideWithValue(
            const FakeFirebaseFundamentalsRepository(),
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

    final collection = tester.getTopLeft(
      find.byKey(const Key('fundamentals-read-collection')),
    );
    final document = tester.getTopLeft(
      find.byKey(const Key('fundamentals-read-document')),
    );
    expect(document.dy, greaterThan(collection.dy));
    expect(document.dx, closeTo(collection.dx, 1));
  });

  testWidgets('reads a collection-group lesson from the repository', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 3200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          firebaseFundamentalsRepositoryProvider.overrideWithValue(
            const FakeFirebaseFundamentalsRepository(lessons: [sampleLesson]),
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

    await tester.ensureVisible(
      find.byKey(const Key('fundamentals-collection-group')),
    );
    await tester.tap(find.byKey(const Key('fundamentals-collection-group')));
    await tester.pumpAndSettle();

    expect(find.text('Vowels'), findsOneWidget);
  });

  testWidgets('listens to courses in realtime', (tester) async {
    tester.view.physicalSize = const Size(800, 3600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          firebaseFundamentalsRepositoryProvider.overrideWithValue(
            const FakeFirebaseFundamentalsRepository(courses: [sampleCourse]),
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

    await tester.ensureVisible(
      find.byKey(const Key('fundamentals-realtime-listen')),
    );
    await tester.tap(find.byKey(const Key('fundamentals-realtime-listen')));
    await tester.pumpAndSettle();

    expect(find.text('Hiragana from Zero'), findsWidgets);
    expect(find.textContaining('participants'), findsWidgets);
    expect(find.textContaining('new call'), findsWidgets);
  });
}
