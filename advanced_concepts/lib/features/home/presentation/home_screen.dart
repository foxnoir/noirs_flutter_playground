import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced Concepts')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Practice app for advanced Flutter topics. Labs land here as the course starts.',
        ),
      ),
    );
  }
}
