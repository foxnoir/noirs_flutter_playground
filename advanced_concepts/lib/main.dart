import 'package:advanced_concepts/core/theme/theme.dart';
import 'package:advanced_concepts/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AdvancedConceptsApp());
}

class AdvancedConceptsApp extends StatelessWidget {
  const AdvancedConceptsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced Concepts',
      theme: getLightTheme(),
      home: const HomeScreen(),
    );
  }
}
