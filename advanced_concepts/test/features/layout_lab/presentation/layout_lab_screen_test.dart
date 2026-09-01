import 'package:advanced_concepts/features/layout_lab/presentation/layout_lab_screen.dart';
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
  testWidgets('LayoutLabScreen shows Flexible vs Expanded and PreferredSize', (
    tester,
  ) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LayoutLabScreen(),
      ),
    );
    await tester.pump();

    expect(find.widgetWithText(AppBar, 'Layout'), findsOneWidget);
    expect(find.text('Row overflow'), findsOneWidget);
    expect(find.text('Flexible'), findsWidgets);
    expect(find.text('Expanded'), findsWidgets);
    expect(find.text('leftover'), findsOneWidget);
    expect(find.text('PreferredSize / AppBar'), findsOneWidget);

    final flexibleWidth = tester
        .getSize(find.byKey(const Key('layout-lab-flexible-fill')))
        .width;
    final expandedWidth = tester
        .getSize(find.byKey(const Key('layout-lab-expanded-fill')))
        .width;
    expect(flexibleWidth, lessThan(expandedWidth));
  });

  testWidgets('PreferredSize 96 is taller than the AppBar demo', (
    tester,
  ) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LayoutLabScreen(),
      ),
    );
    await tester.pump();

    await tester.ensureVisible(find.byType(PreferredSize));
    final preferred = tester.widget<PreferredSize>(find.byType(PreferredSize));
    expect(preferred.preferredSize.height, 96);
  });
}
