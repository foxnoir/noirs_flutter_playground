import 'package:flutter/material.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.provider1)),
      body: Center(child: Text(l10n.counter)),
    );
  }
}
