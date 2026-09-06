import 'package:flutter/material.dart';

class FirebaseFundamentalsDevtoolsHint extends StatelessWidget {
  const FirebaseFundamentalsDevtoolsHint({required this.body, super.key});

  final String body;

  @override
  Widget build(BuildContext context) {
    return Text(body, style: Theme.of(context).textTheme.bodyMedium);
  }
}
