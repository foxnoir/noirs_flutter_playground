import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/router/placeholder_screen.dart';

void main() {
  testWidgets('PlaceholderScreen shows the given title', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: PlaceholderScreen(title: 'Coming soon')),
    );

    expect(find.text('Coming soon'), findsNWidgets(2));
  });
}
