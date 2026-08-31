import 'package:advanced_concepts/core/router/app_router_names.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.missing)),
      body: Center(
        child: FilledButton(
          onPressed: () => context.goNamed(AppRouteNames.landing),
          child: Text(l10n.goToLanding),
        ),
      ),
    );
  }
}
