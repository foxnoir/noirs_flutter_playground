import 'package:flutter/material.dart';
import 'package:riverpod_basic_starter/l10n/app_localizations.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.one)),
      body: Center(child: Text(l10n.page)),
    );
  }
}
