import 'package:advanced_concepts/features/layout_lab/presentation/layout_lab_screen.dart';
import 'package:advanced_concepts/features/layout_lab/presentation/widgets/layout_lab_builder.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/lab_error_stripes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void _useTallSurface(WidgetTester tester, {double width = 400}) {
  tester.view.physicalSize = Size(width, 4000);
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
    expect(find.text('Flexible'), findsWidgets);
    expect(find.text('Expanded'), findsWidgets);
    expect(find.text('leftover'), findsOneWidget);
    expect(find.text('PreferredSize / AppBar'), findsOneWidget);

    await tester.ensureVisible(find.text('LayoutBuilder vs MediaQuery'));
    expect(find.text('LayoutBuilder vs MediaQuery'), findsOneWidget);
    await tester.ensureVisible(find.text('Breakpoints'));
    expect(find.text('Breakpoints'), findsOneWidget);
    expect(find.byKey(const Key('layout-lab-breakpoint-chip')), findsOneWidget);

    await tester.ensureVisible(find.text('Row overflow'));
    expect(find.text('Row overflow'), findsOneWidget);

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

  testWidgets('compact width stacks breakpoint tiles', (tester) async {
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

    await tester.ensureVisible(
      find.byKey(const Key('layout-lab-breakpoint-chip')),
    );
    expect(
      find.descendant(
        of: find.byKey(const Key('layout-lab-breakpoint')),
        matching: find.byType(Row),
      ),
      findsNothing,
    );
    expect(
      find.byKey(const Key('layout-lab-breakpoint-window-chip')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('layout-lab-breakpoint-track')),
      findsOneWidget,
    );
    expect(find.textContaining('compact'), findsWidgets);
  });

  testWidgets(
    'MediaQuery child overflows a 120 parent; LayoutBuilder child fits',
    (tester) async {
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

      await tester.ensureVisible(
        find.byKey(const Key('layout-lab-builder-overflow')),
      );

      final overflowPx = (400 - LayoutLabBuilder.parentWidth).round();
      expect(find.byType(LabErrorStripes), findsWidgets);
      expect(find.textContaining('OVERFLOWED BY $overflowPx'), findsOneWidget);

      final fit = tester.getSize(
        find.byKey(const Key('layout-lab-builder-fit')),
      );
      expect(fit.width, LayoutLabBuilder.parentWidth);
    },
  );

  testWidgets('medium width puts breakpoint tiles in a row', (tester) async {
    _useTallSurface(tester, width: 800);
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LayoutLabScreen(),
      ),
    );
    await tester.pump();

    await tester.ensureVisible(find.byKey(const Key('layout-lab-breakpoint')));
    expect(
      find.descendant(
        of: find.byKey(const Key('layout-lab-breakpoint')),
        matching: find.byType(Row),
      ),
      findsOneWidget,
    );
  });
}
