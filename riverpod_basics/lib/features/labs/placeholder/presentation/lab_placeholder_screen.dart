import 'package:flutter/material.dart';
import 'package:riverpod_basics/core/router/placeholder_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class LabPlaceholderScreen extends StatelessWidget {
  const LabPlaceholderScreen({required this.number, super.key});

  final int number;

  @override
  Widget build(BuildContext context) {
    return PlaceholderScreen(
      title: AppLocalizations.of(context).labNumber(number),
    );
  }
}
