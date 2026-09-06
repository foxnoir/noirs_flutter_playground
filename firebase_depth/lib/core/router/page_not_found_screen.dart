import 'package:firebase_depth/core/router/app_router_names.dart';
import 'package:firebase_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.missing)),
      body: Center(
        child: FilledButton(
          onPressed: () => context.goNamed(AppRouteNames.home),
          child: Text(l10n.back),
        ),
      ),
    );
  }
}
