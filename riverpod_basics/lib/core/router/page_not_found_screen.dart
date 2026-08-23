import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basics/core/router/app_router_names.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.pageNotFound)),
      body: Center(
        child: FilledButton(
          onPressed: () => context.goNamed(AppRouteNames.landing),
          child: Text(l10n.goToLanding),
        ),
      ),
    );
  }
}
