import 'package:advanced_concepts/features/sealed_lab/presentation/sealed_lab_screen.dart';
import 'package:advanced_concepts/features/sealed_lab/presentation/widgets/sealed_lab_code_snippets.dart';
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
        home: SealedLabScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Sealed lab shows JSON-subclass wrong vs BookMetadata family', (
    tester,
  ) async {
    await _pumpLab(tester);

    expect(find.widgetWithText(AppBar, 'Sealed'), findsOneWidget);
    expect(find.text('wrong  ·  subclass for a JSON field'), findsOneWidget);
    expect(find.text('works  ·  sealed BookMetadata'), findsOneWidget);
    expect(find.text(SealedLabCodeSnippets.jsonSubclass), findsOneWidget);
    expect(find.text(SealedLabCodeSnippets.bookMetadata), findsOneWidget);
    expect(find.text(SealedLabCodeSnippets.hardcover), findsOneWidget);
    expect(find.text(SealedLabCodeSnippets.hardcoverSwitch), findsOneWidget);
    expect(find.text(SealedLabCodeSnippets.paperback), findsNothing);
    expect(find.text(SealedLabCodeSnippets.ebook), findsNothing);
    expect(find.byKey(const Key('sealed-lab-hardcover')), findsOneWidget);
    expect(find.text('Fourth Wing'), findsWidgets);
    expect(find.text('switch → Hardcover'), findsOneWidget);
  });

  testWidgets('Tap Ebook updates the switch format', (tester) async {
    await _pumpLab(tester);

    await tester.ensureVisible(find.byKey(const Key('sealed-lab-ebook')));
    await tester.tap(find.byKey(const Key('sealed-lab-ebook')));
    await tester.pump();

    expect(find.text('switch → Ebook'), findsOneWidget);
    expect(find.text('switch → Hardcover'), findsNothing);
    expect(find.text(SealedLabCodeSnippets.bookMetadata), findsOneWidget);
    expect(find.text(SealedLabCodeSnippets.ebook), findsOneWidget);
    expect(find.text(SealedLabCodeSnippets.ebookSwitch), findsOneWidget);
    expect(find.text(SealedLabCodeSnippets.hardcover), findsNothing);
    expect(find.text(SealedLabCodeSnippets.hardcoverSwitch), findsNothing);
  });
}
