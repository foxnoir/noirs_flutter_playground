import 'package:advanced_concepts/features/generics_general_lab/domain/generics_lab_items.dart';
import 'package:advanced_concepts/features/generics_general_lab/presentation/generics_general_lab_screen.dart';
import 'package:advanced_concepts/features/generics_general_lab/presentation/widgets/generics_lab_code_snippets.dart';
import 'package:advanced_concepts/features/generics_general_lab/presentation/widgets/generics_lab_rows.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

String _assetName(WidgetTester tester, Key key) {
  final image = tester.widget<Image>(find.byKey(key));
  return (image.image as AssetImage).assetName;
}

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
        home: GenericsGeneralLabScreen(),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  test('lab items are Ada and Fourth Wing', () {
    expect(genericsLabAda.nickname, 'Ada');
    expect(genericsLabFourthWing.title, 'Fourth Wing');
  });

  testWidgets('General shows two tiles vs GenericsLabTile', (tester) async {
    await _pumpLab(tester);

    expect(find.widgetWithText(AppBar, 'General'), findsOneWidget);
    expect(find.text('wrong  ·  two tiles'), findsOneWidget);
    expect(find.text('works  ·  GenericsLabTile<T>'), findsOneWidget);
    expect(find.text('class GenericsLabTile<T>'), findsOneWidget);
    expect(find.text(GenericsLabCodeSnippets.twoTiles), findsOneWidget);
    expect(find.text(GenericsLabCodeSnippets.tile), findsOneWidget);
    expect(find.text('Ada'), findsOneWidget);
    expect(find.text('User List'), findsOneWidget);
    expect(find.text('Fourth Wing'), findsOneWidget);
    expect(find.text('Example HTTP'), findsOneWidget);
    expect(find.text('T = User'), findsOneWidget);
    expect(
      _assetName(tester, const Key('generics-lab-user-icon')),
      GenericsLabIcons.userSelected,
    );
    expect(
      _assetName(tester, const Key('generics-lab-book-icon')),
      GenericsLabIcons.bookIdle,
    );
  });

  testWidgets('tap Fourth Wing switches T to Book', (tester) async {
    await _pumpLab(tester);

    expect(find.text('T = User'), findsOneWidget);
    await tester.ensureVisible(find.byKey(const Key('generics-lab-book')));
    await tester.tap(find.byKey(const Key('generics-lab-book')));
    await tester.pump();

    expect(find.text('T = Book'), findsOneWidget);
    expect(find.text('T = User'), findsNothing);
    expect(
      _assetName(tester, const Key('generics-lab-user-icon')),
      GenericsLabIcons.userIdle,
    );
    expect(
      _assetName(tester, const Key('generics-lab-book-icon')),
      GenericsLabIcons.bookSelected,
    );
  });
}
