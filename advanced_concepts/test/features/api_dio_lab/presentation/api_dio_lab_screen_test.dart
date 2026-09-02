import 'package:advanced_concepts/core/errors/app_failure.dart';
import 'package:advanced_concepts/features/api_dio_lab/data/repositories/api_dio_lab_repository.dart';
import 'package:advanced_concepts/features/api_dio_lab/domain/entities/book.dart';
import 'package:advanced_concepts/features/api_dio_lab/presentation/api_dio_lab_screen.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/error_widget.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_api_dio_lab_repository.dart';

const _fourthWing = Book(
  id: '3',
  title: 'Fourth Wing',
  author: 'Rebecca Yarros',
  status: BookStatus.finished,
);

void _useTallSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 1400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> _pumpLab(
  WidgetTester tester, {
  FakeApiDioLabRepository? repository,
}) async {
  _useTallSurface(tester);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        apiDioLabRepositoryProvider.overrideWithValue(
          repository ?? FakeApiDioLabRepository(books: const [_fourthWing]),
        ),
      ],
      child: const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ApiDioLabScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _tapKey(WidgetTester tester, Key key) async {
  final finder = find.byKey(key);
  await tester.ensureVisible(finder);
  await tester.tap(finder);
}

void main() {
  testWidgets('unreachable backend maps to NetworkFailure on first load', (
    tester,
  ) async {
    await _pumpLab(
      tester,
      repository: FakeApiDioLabRepository(error: const NetworkFailure()),
    );

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(
      find.text('Could not reach the server. Check your connection.'),
      findsOneWidget,
    );
  });

  testWidgets('Dio lab lists books from the repository', (tester) async {
    await _pumpLab(tester);

    expect(find.widgetWithText(AppBar, 'Example Dio'), findsOneWidget);
    expect(find.text('Fourth Wing'), findsOneWidget);
    expect(find.text('Rebecca Yarros'), findsOneWidget);
    expect(find.text('Finished'), findsOneWidget);
    expect(find.text('GET /books'), findsNothing);
    expect(find.byKey(const Key('api-dio-lab-scenario-books')), findsNothing);
  });

  testWidgets('Server drill maps to ServerFailure, retry loads the shelf', (
    tester,
  ) async {
    await _pumpLab(tester);

    await _tapKey(tester, const Key('api-dio-lab-scenario-server'));
    await tester.pumpAndSettle();

    expect(find.byType(ErrorWidget), findsOneWidget);
    expect(find.text('The server failed. Try again.'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(find.text('Fourth Wing'), findsOneWidget);
    expect(find.text('GET /books'), findsOneWidget);
  });

  testWidgets('Slow drill maps to TimeoutFailure copy', (tester) async {
    await _pumpLab(tester);

    await _tapKey(tester, const Key('api-dio-lab-scenario-timeout'));
    await tester.pumpAndSettle();

    expect(find.text('The server took too long to answer.'), findsOneWidget);
  });

  testWidgets('Offline drill maps to NetworkFailure copy', (tester) async {
    await _pumpLab(tester);

    await _tapKey(tester, const Key('api-dio-lab-scenario-offline'));
    await tester.pumpAndSettle();

    expect(
      find.text('Could not reach the server. Check your connection.'),
      findsOneWidget,
    );
  });

  testWidgets('Unstable fails on the third tap, retry loads the shelf', (
    tester,
  ) async {
    await _pumpLab(tester);

    await _tapKey(tester, const Key('api-dio-lab-scenario-unstable'));
    await tester.pumpAndSettle();
    expect(find.text('Fourth Wing'), findsOneWidget);

    await _tapKey(tester, const Key('api-dio-lab-scenario-unstable'));
    await tester.pumpAndSettle();
    expect(find.text('Fourth Wing'), findsOneWidget);

    await _tapKey(tester, const Key('api-dio-lab-scenario-unstable'));
    await tester.pumpAndSettle();
    expect(find.text('The server took too long to answer.'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('Fourth Wing'), findsOneWidget);
    expect(find.text('GET /books'), findsOneWidget);
  });

  testWidgets('wrong search maps to UnauthorizedFailure copy', (tester) async {
    await _pumpLab(
      tester,
      repository: FakeApiDioLabRepository(
        books: const [_fourthWing],
        match: _fourthWing,
      ),
    );

    await tester.tap(find.byKey(const Key('api-dio-lab-search')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('api-dio-lab-search-title')),
      'Fourth Wing',
    );
    await tester.enterText(
      find.byKey(const Key('api-dio-lab-search-author')),
      'Sarah J. Maas',
    );
    await tester.tap(find.byKey(const Key('api-dio-lab-search-submit')));
    await tester.pumpAndSettle();

    expect(find.text('That request was not allowed.'), findsOneWidget);
  });

  testWidgets('matching search shows the HTTP call in a snackbar', (
    tester,
  ) async {
    await _pumpLab(
      tester,
      repository: FakeApiDioLabRepository(
        books: const [_fourthWing],
        match: _fourthWing,
      ),
    );

    await tester.tap(find.byKey(const Key('api-dio-lab-search')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('api-dio-lab-search-title')),
      'Fourth Wing',
    );
    await tester.enterText(
      find.byKey(const Key('api-dio-lab-search-author')),
      'Rebecca Yarros',
    );
    await tester.tap(find.byKey(const Key('api-dio-lab-search-submit')));
    await tester.pumpAndSettle();

    expect(find.text('POST /search · Fourth Wing'), findsOneWidget);
  });

  testWidgets('add book posts and lists the new title', (tester) async {
    await _pumpLab(tester);

    await tester.tap(find.byKey(const Key('api-dio-lab-add')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('api-dio-lab-book-title')),
      'Wind and Truth',
    );
    await tester.enterText(
      find.byKey(const Key('api-dio-lab-book-author')),
      'Brandon Sanderson',
    );
    await tester.tap(find.byKey(const Key('api-dio-lab-book-save')));
    await tester.pumpAndSettle();

    expect(find.text('Wind and Truth'), findsOneWidget);
    expect(find.text('POST /books · Wind and Truth'), findsOneWidget);
  });

  testWidgets('edit book status puts the new reading state', (tester) async {
    await _pumpLab(tester);

    await tester.tap(find.byKey(const Key('api-dio-lab-edit-3')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('api-dio-lab-status-reading')));
    await tester.tap(find.byKey(const Key('api-dio-lab-book-save')));
    await tester.pumpAndSettle();

    expect(find.text('Reading'), findsOneWidget);
    expect(find.text('PUT /books · Fourth Wing'), findsOneWidget);
  });

  testWidgets('delete book removes it from the shelf', (tester) async {
    await _pumpLab(tester);

    await tester.tap(find.byKey(const Key('api-dio-lab-delete-3')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('api-dio-lab-book-delete-confirm')));
    await tester.pumpAndSettle();

    expect(find.text('Fourth Wing'), findsNothing);
    expect(find.text('DELETE /books · Fourth Wing'), findsOneWidget);
  });
}
