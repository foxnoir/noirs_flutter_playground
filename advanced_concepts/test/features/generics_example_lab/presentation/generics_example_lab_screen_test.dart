import 'package:advanced_concepts/features/generics_example_lab/presentation/generics_example_lab_screen.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void _useTallSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 2400);
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
        home: GenericsExampleLabScreen(),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('Example shows User List in the HTTP row layout', (tester) async {
    await _pumpLab(tester);

    expect(find.widgetWithText(AppBar, 'Example'), findsOneWidget);
    expect(find.text('T = User'), findsOneWidget);
    expect(find.byKey(const Key('generics-example-user-1')), findsOneWidget);
    expect(find.text('Ada'), findsOneWidget);
    expect(find.text('ada@example.com'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('36'), findsNothing);
    expect(find.byTooltip('Books read this year'), findsWidgets);
    expect(find.text('Fourth Wing'), findsNothing);
  });

  testWidgets('Books uses the same list widget with T = Book', (tester) async {
    await _pumpLab(tester);

    await tester.tap(find.text('Books'));
    await tester.pump();

    expect(find.text('T = Book'), findsOneWidget);
    expect(find.text('T = User'), findsNothing);
    expect(find.byKey(const Key('generics-example-book-3')), findsOneWidget);
    expect(find.text('Fourth Wing'), findsOneWidget);
    expect(find.text('Rebecca Yarros'), findsWidgets);
    expect(find.text('Ada'), findsNothing);
  });
}
