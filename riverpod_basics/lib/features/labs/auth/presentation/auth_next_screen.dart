import 'package:flutter/material.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

/// Protected page. Redirect sends you back to the hub when logged out.
class AuthNextScreen extends StatelessWidget {
  const AuthNextScreen({super.key});

  static const imageAsset = 'assets/img/auth_dragon.png';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.authNextScreen)),
      body: Center(
        child: Image.asset(imageAsset, width: 280, fit: BoxFit.contain),
      ),
    );
  }
}
