import 'package:advanced_concepts/features/api_compare_lab/presentation/api_compare_lab_screen.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void _useTallSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 1400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> _pumpLab(WidgetTester tester) async {
  _useTallSurface(tester);
  await tester.pumpWidget(
    const ProviderScope(
      child: MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ApiCompareLabScreen(),
      ),
    ),
  );
}

void main() {
  testWidgets('GET then Next walks both _send then Dio onRequest', (
    tester,
  ) async {
    await _pumpLab(tester);

    expect(find.widgetWithText(AppBar, 'HTTP vs Dio'), findsOneWidget);
    expect(
      find.text('Pick GET, DELETE, or a drill. Next walks both stacks.'),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('api-compare-lab-get')));
    await tester.pump();

    expect(find.text("ApiClient.get('/books')"), findsOneWidget);
    expect(find.text("DioApiClient.get('/books')"), findsOneWidget);

    await tester.tap(find.byKey(const Key('api-compare-lab-next')));
    await tester.pump();

    expect(find.text('ApiClient._send'), findsOneWidget);
    expect(find.text('DioApiClient._send'), findsOneWidget);
    expect(
      find.text(
        'No interceptors. Headers, timeout, and status mapping live in _send.',
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        '_send only forwards to _dio.request. Logging and mapping are interceptors.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('api-compare-lab-next')));
    await tester.pump();

    expect(find.text('(no interceptor)'), findsOneWidget);
    expect(find.text('DioLogInterceptor.onRequest'), findsOneWidget);
  });

  testWidgets('Next three times reaches the GET fire beat', (tester) async {
    await _pumpLab(tester);

    await tester.tap(find.byKey(const Key('api-compare-lab-get')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('api-compare-lab-next')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('api-compare-lab-next')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('api-compare-lab-next')));
    await tester.pump();

    expect(find.text('http.Client.get'), findsOneWidget);
    expect(find.text('_dio.request'), findsOneWidget);
    expect(
      find.text('The HTTP request leaves the device here.'),
      findsNWidgets(2),
    );
    expect(find.text('GET fires'), findsNWidgets(2));
  });

  testWidgets('DELETE walks delete then DELETE fires', (tester) async {
    await _pumpLab(tester);

    await tester.tap(find.byKey(const Key('api-compare-lab-delete')));
    await tester.pump();

    expect(find.text("ApiClient.delete('/books/:id')"), findsOneWidget);
    expect(find.text("DioApiClient.delete('/books/:id')"), findsOneWidget);
    expect(
      find.text(
        'Same _send vs interceptors as GET. Path is /books/:id. DELETE without Bearer lab is 401. package:http sets the header in _send; Dio uses DioAuthInterceptor.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('api-compare-lab-next')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('api-compare-lab-next')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('api-compare-lab-next')));
    await tester.pump();

    expect(find.text('http.Client.delete'), findsOneWidget);
    expect(find.text('_dio.request'), findsOneWidget);
    expect(find.text('DELETE fires'), findsNWidgets(2));
  });
}
