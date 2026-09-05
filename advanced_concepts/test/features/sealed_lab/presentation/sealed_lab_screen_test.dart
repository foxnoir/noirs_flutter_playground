import 'package:advanced_concepts/features/sealed_lab/domain/book_format.dart';
import 'package:advanced_concepts/features/sealed_lab/presentation/sealed_lab_code_snippets.dart';
import 'package:advanced_concepts/features/sealed_lab/presentation/sealed_lab_screen.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
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
    const MaterialApp(
      locale: Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SealedLabScreen(),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('Sealed lab shows JSON-subclass wrong vs BookFormat family', (
    tester,
  ) async {
    await _pumpLab(tester);

    expect(
      find.widgetWithText(AppBar, 'Sealed (plus extends)'),
      findsOneWidget,
    );
    expect(find.text('wrong  ·  subclass for a JSON field'), findsOneWidget);
    expect(find.text('works  ·  sealed BookFormat'), findsOneWidget);
    expect(find.text(SealedLabCodeSnippets.jsonSubclass), findsOneWidget);
    expect(find.text(SealedLabCodeSnippets.sealedFamily), findsOneWidget);
    expect(find.text(SealedLabCodeSnippets.formatSwitch), findsOneWidget);
    expect(find.byKey(const Key('sealed-lab-hardcover')), findsOneWidget);
    expect(find.text(fourthWingHardcover.title), findsWidgets);
    expect(find.text('switch → Hardcover'), findsOneWidget);
  });

  testWidgets('Tap Ebook updates the switch line', (tester) async {
    await _pumpLab(tester);

    await tester.ensureVisible(find.byKey(const Key('sealed-lab-ebook')));
    await tester.tap(find.byKey(const Key('sealed-lab-ebook')));
    await tester.pump();

    expect(find.text('switch → Ebook'), findsOneWidget);
    expect(find.text('switch → Hardcover'), findsNothing);
  });
}
