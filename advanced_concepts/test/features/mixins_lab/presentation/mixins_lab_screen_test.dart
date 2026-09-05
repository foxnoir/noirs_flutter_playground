import 'package:advanced_concepts/features/mixins_lab/presentation/mixins_lab_busy_mixin.dart';
import 'package:advanced_concepts/features/mixins_lab/presentation/mixins_lab_screen.dart';
import 'package:advanced_concepts/features/mixins_lab/presentation/widgets/mixins_lab_code_snippets.dart';
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
      home: MixinsLabScreen(),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('Mixins lab shows illegal extends vs MixinsLabBusyMixin', (
    tester,
  ) async {
    await _pumpLab(tester);

    expect(find.widgetWithText(AppBar, 'Mixins'), findsOneWidget);
    expect(find.text('wrong  ·  two extends'), findsOneWidget);
    expect(find.text('works  ·  with MixinsLabBusyMixin'), findsOneWidget);
    expect(find.text('our mixin MixinsLabBusyMixin'), findsOneWidget);
    expect(find.text(MixinsLabCodeSnippets.illegal), findsOneWidget);
    expect(find.text(MixinsLabCodeSnippets.withMixin), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Reload'), findsOneWidget);
    expect(find.text('idle'), findsOneWidget);
  });

  testWidgets('Save goes busy; Reload card stays idle', (tester) async {
    await _pumpLab(tester);

    await tester.ensureVisible(find.byKey(const Key('mixins-lab-save')));
    await tester.tap(find.byKey(const Key('mixins-lab-save')));
    await tester.pump();

    expect(find.byKey(const Key('mixins-lab-save-busy')), findsOneWidget);
    expect(find.byKey(const Key('mixins-lab-reload-busy')), findsNothing);
    expect(find.text('busy'), findsOneWidget);
    expect(find.text('idle'), findsOneWidget);

    await tester.pump(mixinsLabBusyDelay);
    await tester.pump();

    expect(find.byKey(const Key('mixins-lab-save-busy')), findsNothing);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('idle'), findsOneWidget);
  });
}
