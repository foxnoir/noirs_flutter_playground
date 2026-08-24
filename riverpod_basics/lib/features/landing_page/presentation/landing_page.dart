import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basics/core/router/app_router_names.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final destinations = [
      (label: l10n.noProvider, routeName: AppRouteNames.noProvider),
      (label: l10n.stateProvider, routeName: AppRouteNames.stateProvider),
      (label: l10n.notifierProvider, routeName: AppRouteNames.notifierProvider),
      (
        label: l10n.asyncNotifierPersistentState,
        routeName: AppRouteNames.asyncNotifierPersistentState,
      ),
      (
        label: l10n.asyncNotifierNonPersistentState,
        routeName: AppRouteNames.asyncNotifierNonPersistentState,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
      ),
      body: ListView(
        children: [
          for (final destination in destinations)
            ListTile(
              title: Text(destination.label),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.pushNamed(destination.routeName),
            ),
        ],
      ),
    );
  }
}
