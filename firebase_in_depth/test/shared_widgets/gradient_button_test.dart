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
}
