import 'package:advanced_concepts/features/lists_lab/presentation/lists_lab_screen.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void _useTallSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('ListsLabScreen shows rules, ListView preview, and problems', (
    tester,
  ) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ListsLabScreen(),
      ),
    );
    await tester.pump();

    expect(find.widgetWithText(AppBar, 'Lists'), findsOneWidget);
    expect(find.text('ListView.builder'), findsWidgets);
    expect(find.text('Axis.horizontal'), findsOneWidget);
    expect(find.text('GridView.builder'), findsOneWidget);
    expect(find.text('CustomScrollView + slivers'), findsOneWidget);
    expect(find.text('Eager vs lazy'), findsOneWidget);
    expect(find.text('Unbounded height'), findsOneWidget);
    expect(
      find.text('Vertical viewport was given unbounded height.'),
      findsOneWidget,
    );
    expect(find.byKey(const Key('lists-lab-unbounded-wrong')), findsOneWidget);
    expect(find.byKey(const Key('lists-lab-unbounded-right')), findsOneWidget);

    final built = tester.widget<Text>(find.byKey(const Key('lists-lab-built')));
    expect(built.data, contains('cells'));
    expect(built.data, contains('builds'));
    expect(built.data, isNot(contains('cells 48 / 48')));
  });

  testWidgets('GridView, Sliver, and Horizontal segments rebuild the preview', (
    tester,
  ) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ListsLabScreen(),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('GridView').last);
    await tester.pump();
    expect(find.text('GridView.builder(gridDelegate: …)'), findsOneWidget);

    await tester.tap(find.text('Sliver'));
    await tester.pump();
    expect(
      find.text('CustomScrollView(slivers: [SliverGrid, SliverList])'),
      findsOneWidget,
    );
    expect(find.text('SliverToBoxAdapter'), findsOneWidget);

    await tester.tap(find.text('Horizontal'));
    await tester.pump();
    expect(
      find.text('ListView.builder(scrollDirection: Axis.horizontal, …)'),
      findsOneWidget,
    );
  });
}
