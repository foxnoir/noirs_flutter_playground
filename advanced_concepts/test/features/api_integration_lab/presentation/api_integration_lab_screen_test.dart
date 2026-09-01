import 'package:advanced_concepts/features/api_integration_lab/data/data_sources/book_api_data_source.dart';
import 'package:advanced_concepts/features/api_integration_lab/presentation/api_integration_lab_screen.dart';
import 'package:advanced_concepts/features/api_integration_lab/presentation/widgets/api_lab_timeout.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_book_http_client.dart';

void _useTallSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 4000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> _pumpLab(WidgetTester tester) async {
  _useTallSurface(tester);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        httpClientProvider.overrideWithValue(fakeBookHttpClient()),
        apiLabTimeoutsProvider.overrideWithValue(
          const ApiLabTimeouts(
            unguarded: Duration(seconds: 5),
            guarded: Duration(milliseconds: 10),
          ),
        ),
      ],
      child: const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ApiIntegrationLabScreen(),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('API lab shows unified, timeout, and network sections', (
    tester,
  ) async {
    await _pumpLab(tester);

    expect(find.widgetWithText(AppBar, 'API HTTP'), findsOneWidget);
    expect(find.text('Unified API class'), findsOneWidget);
    expect(find.text('Timeout'), findsOneWidget);
    expect(find.text('Network errors'), findsOneWidget);
    expect(find.text('Fourth Wing'), findsNothing);

    await tester.tap(find.byKey(const Key('api-lab-books')));
    await tester.pumpAndSettle();
    expect(find.textContaining('Fourth Wing'), findsOneWidget);
    expect(find.textContaining('Rebecca Yarros'), findsWidgets);
  });

  testWidgets('GET /success parses wrapped data', (tester) async {
    await _pumpLab(tester);
    await tester.tap(find.byKey(const Key('api-lab-success')));
    await tester.pumpAndSettle();
    expect(find.textContaining('A Court of Silver Flames'), findsOneWidget);
  });

  testWidgets('GET /error maps to ServerFailure copy', (tester) async {
    await _pumpLab(tester);
    await tester.ensureVisible(find.byKey(const Key('api-lab-error')));
    await tester.tap(find.byKey(const Key('api-lab-error')));
    await tester.pumpAndSettle();
    expect(find.text('The server failed. Try again.'), findsOneWidget);
  });

  testWidgets('wrong identify maps to UnauthorizedFailure copy', (
    tester,
  ) async {
    await _pumpLab(tester);
    await tester.ensureVisible(find.byKey(const Key('api-lab-unauthorized')));
    await tester.tap(find.byKey(const Key('api-lab-unauthorized')));
    await tester.pumpAndSettle();
    expect(find.text('That request was not allowed.'), findsOneWidget);
  });

  testWidgets('offline maps to NetworkFailure copy', (tester) async {
    await _pumpLab(tester);
    await tester.ensureVisible(find.byKey(const Key('api-lab-offline')));
    await tester.tap(find.byKey(const Key('api-lab-offline')));
    await tester.pumpAndSettle();
    expect(
      find.text('Could not reach the server. Check your connection.'),
      findsOneWidget,
    );
  });

  testWidgets('guarded timeout maps to TimeoutFailure copy', (tester) async {
    await _pumpLab(tester);
    await tester.ensureVisible(find.byKey(const Key('api-lab-timeout-right')));
    await tester.tap(find.byKey(const Key('api-lab-timeout-right')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 30));
    await tester.pumpAndSettle();
    expect(find.text('The server took too long to answer.'), findsOneWidget);
  });
}
