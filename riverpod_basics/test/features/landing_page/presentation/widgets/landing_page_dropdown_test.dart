import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/theme/theme.dart';
import 'package:riverpod_basics/features/landing_page/presentation/widgets/landing_page_dropdown.dart';

void main() {
  final theme = getLightTheme();

  Widget app({required Widget home}) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(body: home),
    );
  }

  testWidgets('LandingPageDropdown expands and calls onTap', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      app(
        home: LandingPageDropdown(
          title: 'Providers',
          items: [
            LandingPageDropdownItem(
              label: 'StateProvider',
              onTap: () => tapped = true,
            ),
          ],
        ),
      ),
    );

    expect(find.text('StateProvider'), findsNothing);

    await tester.tap(find.text('Providers'));
    await tester.pumpAndSettle();

    expect(find.text('StateProvider'), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsOneWidget);

    await tester.tap(find.text('StateProvider'));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('LandingPageDropdown items without onTap have no chevron', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(
        home: const LandingPageDropdown(
          title: 'Labs',
          items: [LandingPageDropdownItem(label: 'Lab 1')],
        ),
      ),
    );

    await tester.tap(find.text('Labs'));
    await tester.pumpAndSettle();

    expect(find.text('Lab 1'), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsNothing);
  });

  testWidgets('section title uses theme titleLarge teal', (tester) async {
    await tester.pumpWidget(
      app(
        home: const LandingPageDropdown(
          title: 'Providers',
          items: [LandingPageDropdownItem(label: 'StateProvider')],
        ),
      ),
    );

    final titleFinder = find.text('Providers');
    final title = tester.widget<Text>(titleFinder);
    final appliedTheme = Theme.of(tester.element(titleFinder));
    expect(title.style?.color, AppColor.teal);
    expect(title.style?.fontSize, appliedTheme.textTheme.titleLarge?.fontSize);
  });

  testWidgets('item caption is smaller and in parentheses', (tester) async {
    await tester.pumpWidget(
      app(
        home: const LandingPageDropdown(
          title: 'Labs',
          items: [
            LandingPageDropdownItem(
              label: 'Add User',
              caption: 'Auto Dispose Provider',
            ),
          ],
        ),
      ),
    );

    await tester.tap(find.text('Labs'));
    await tester.pumpAndSettle();

    expect(find.text('Add User'), findsOneWidget);
    final captionFinder = find.text(' (Auto Dispose Provider)');
    final caption = tester.widget<Text>(captionFinder);
    final appliedTheme = Theme.of(tester.element(captionFinder));
    expect(caption.style?.fontSize, appliedTheme.textTheme.bodySmall?.fontSize);
    expect(caption.style?.color, appliedTheme.colorScheme.onSurfaceVariant);
  });
}
