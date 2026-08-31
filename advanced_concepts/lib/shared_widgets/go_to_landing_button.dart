import 'package:advanced_concepts/core/router/app_router_names.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoToLandingButton extends StatelessWidget {
  const GoToLandingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: FilledButton(
          key: const Key('go-to-landing'),
          onPressed: () => context.goNamed(AppRouteNames.landing),
          child: Text(l10n.goToLanding),
        ),
      ),
    );
  }
}
