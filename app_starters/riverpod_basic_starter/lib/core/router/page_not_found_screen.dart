import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basic_starter/core/router/app_router_names.dart';
import 'package:riverpod_basic_starter/l10n/app_localizations.dart';

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
