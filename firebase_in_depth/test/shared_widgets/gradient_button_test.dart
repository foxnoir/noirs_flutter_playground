import 'package:firebase_in_depth/core/theme/theme.dart';
import 'package:firebase_in_depth/shared_widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('GradientButton shows the label and calls onPressed', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: getLightTheme(),
        home: Scaffold(
          body: GradientButton(label: 'Retry', onPressed: () => tapped = true),
        ),
      ),
    );

    expect(find.text('Retry'), findsOneWidget);
    await tester.tap(find.byType(GradientButton));
    await tester.pump();
    expect(tapped, isTrue);
  });

  testWidgets('GradientButton uses the given gradient colors', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: getLightTheme(),
        home: const Scaffold(
          body: GradientButton(
            label: 'Sign in',
            startColor: AppColor.secondarySoft,
            endColor: AppColor.secondary,
          ),
        ),
      ),
    );

    final ink = tester.widget<Ink>(find.byType(Ink));
    final decoration = ink.decoration! as BoxDecoration;
    final gradient = decoration.gradient! as LinearGradient;
    expect(gradient.colors, [AppColor.secondarySoft, AppColor.secondary]);
    expect(gradient.begin, Alignment.topCenter);
    expect(gradient.end, Alignment.bottomCenter);
  });

  testWidgets('GradientButton.primary uses the theme purple gradient', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: getLightTheme(),
        home: const Scaffold(body: GradientButton.primary(label: 'Sign in')),
      ),
    );

    final scheme = getLightTheme().colorScheme;
    final ink = tester.widget<Ink>(find.byType(Ink));
    final decoration = ink.decoration! as BoxDecoration;
    final gradient = decoration.gradient! as LinearGradient;
    expect(gradient.colors, [scheme.primaryContainer, scheme.primary]);
  });

  testWidgets('GradientButton is not full width', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: getLightTheme(),
        home: const Scaffold(
          body: Center(child: GradientButton(label: 'Retry')),
        ),
      ),
    );

    final button = tester.getRect(find.byType(GradientButton));
    final screen = tester.getRect(find.byType(Scaffold));
    expect(button.width, lessThan(screen.width / 2));
  });

  testWidgets('GradientButton expanded fills the parent width', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: getLightTheme(),
        home: const Scaffold(
          body: SizedBox(
            width: 320,
            child: GradientButton(label: 'Sign in', expanded: true),
          ),
        ),
      ),
    );

    expect(tester.getSize(find.byType(GradientButton)).width, 320);
  });
}
