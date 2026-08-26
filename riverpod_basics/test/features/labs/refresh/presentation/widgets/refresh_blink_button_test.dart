import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/widgets/refresh_blink_button.dart';

void main() {
  testWidgets('flash overlay is on only while isBlinking', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RefreshBlinkButton(label: 'Refresh', isBlinking: true),
        ),
      ),
    );

    expect(
      tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity,
      0.55,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RefreshBlinkButton(label: 'Refresh', isBlinking: false),
        ),
      ),
    );

    expect(
      tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity,
      0,
    );
  });
}
