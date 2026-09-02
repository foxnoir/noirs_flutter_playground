import 'package:advanced_concepts/features/api_general_lab/presentation/api_general_lab_screen.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void _useTallSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 4000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('General lab explains CRUD and interceptors without live calls', (
    tester,
  ) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ApiGeneralLabScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.widgetWithText(AppBar, 'General'), findsOneWidget);
    expect(find.text('CRUD'), findsOneWidget);
    expect(find.text('Interceptor (Dio)'), findsOneWidget);
    expect(find.text('Unified API class'), findsOneWidget);
    expect(find.text('Timeout'), findsOneWidget);
    expect(find.text('Network errors'), findsOneWidget);
    expect(find.byKey(const Key('api-lab-books')), findsNothing);
    expect(find.text('GET /books'), findsNothing);
  });
}
