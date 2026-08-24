import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

void main() {
  testWidgets('FullWidthElevatedButton shows the label and calls onPressed', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FullWidthElevatedButton(
            label: 'Add User',
            onPressed: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Add User'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    await tester.tap(find.byType(FullWidthElevatedButton));
    await tester.pump();
    expect(tapped, isTrue);
  });
}
