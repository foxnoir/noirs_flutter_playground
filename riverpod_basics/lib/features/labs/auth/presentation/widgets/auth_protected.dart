import 'package:flutter/material.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class AuthProtected extends StatelessWidget {
  const AuthProtected({super.key});

  static const imageAsset = 'assets/img/auth_dragon.png';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.authProtected)),
      body: Center(
        child: Image.asset(imageAsset, width: 280, fit: BoxFit.contain),
      ),
    );
  }
}
