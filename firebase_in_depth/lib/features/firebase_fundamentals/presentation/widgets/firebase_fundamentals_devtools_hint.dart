import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_hint_text.dart';
import 'package:flutter/material.dart';

class FirebaseFundamentalsDevtoolsHint extends StatelessWidget {
  const FirebaseFundamentalsDevtoolsHint({required this.body, super.key});

  final String body;

  @override
  Widget build(BuildContext context) {
    return FirebaseFundamentalsHintText(
      text: body,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
