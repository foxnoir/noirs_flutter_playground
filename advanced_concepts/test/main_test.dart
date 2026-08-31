import 'package:advanced_concepts/features/home/presentation/home_screen.dart';
import 'package:advanced_concepts/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AdvancedConceptsApp starts on the home screen', (tester) async {
    await tester.pumpWidget(const AdvancedConceptsApp());

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Advanced Concepts'), findsOneWidget);
    expect(
      find.text(
        'Practice app for advanced Flutter topics. Labs land here as the course starts.',
      ),
      findsOneWidget,
    );
  });
}
