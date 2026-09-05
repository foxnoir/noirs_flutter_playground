import 'package:advanced_concepts/core/theme/theme.dart';
import 'package:advanced_concepts/features/landing/presentation/widgets/landing_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final theme = getLightTheme();

  Widget app({required Widget home}) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(body: home),
    );
  }

  testWidgets('caption is smaller and in parentheses', (tester) async {
    await tester.pumpWidget(
      app(
        home: LandingListTile(
          label: 'Sealed',
          caption: 'plus extends',
          onTap: () {},
        ),
      ),
    );

    expect(find.text('Sealed'), findsOneWidget);
    final captionFinder = find.text(' (plus extends)');
    final caption = tester.widget<Text>(captionFinder);
    final appliedTheme = Theme.of(tester.element(captionFinder));
    expect(caption.style?.fontSize, appliedTheme.textTheme.bodySmall?.fontSize);
    expect(caption.style?.color, appliedTheme.colorScheme.onSurfaceVariant);
  });
}
