import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/theme/theme.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/widgets/provider_lifetimes_section.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

void main() {
  final theme = getLightTheme();

  Widget app({required Widget home}) {
    return MaterialApp(
      locale: const Locale('en'),
      theme: theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: home),
    );
  }

  TextEditingController controller() {
    final userController = TextEditingController();
    addTearDown(userController.dispose);
    return userController;
  }

  testWidgets('ProviderLifetimesSection shows title, field, and user value', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(
        home: ProviderLifetimesSection(
          title: 'Persistent',
          user: '-',
          controller: controller(),
          onAddPressed: () {},
        ),
      ),
    );

    expect(find.text('Persistent'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Username'), findsOneWidget);
    expect(find.byType(FullWidthElevatedButton), findsOneWidget);
    expect(find.text('Add'), findsOneWidget);
    expect(find.text('User: -'), findsOneWidget);
  });

  testWidgets('ProviderLifetimesSection add button calls onAddPressed', (
    tester,
  ) async {
    var added = false;

    await tester.pumpWidget(
      app(
        home: ProviderLifetimesSection(
          title: 'Persistent',
          user: '-',
          controller: controller(),
          onAddPressed: () => added = true,
        ),
      ),
    );

    await tester.tap(find.text('Add'));
    await tester.pump();

    expect(added, isTrue);
  });

  testWidgets('section title uses theme titleLarge teal', (tester) async {
    await tester.pumpWidget(
      app(
        home: ProviderLifetimesSection(
          title: 'Persistent',
          user: '-',
          controller: controller(),
          onAddPressed: () {},
        ),
      ),
    );

    final titleFinder = find.text('Persistent');
    final title = tester.widget<Text>(titleFinder);
    final appliedTheme = Theme.of(tester.element(titleFinder));
    expect(title.style?.color, AppColor.teal);
    expect(title.style?.fontSize, appliedTheme.textTheme.titleLarge?.fontSize);
  });
}
