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
      (label: l10n.provider1, routeName: AppRouteNames.counter),
      (label: l10n.provider2, routeName: AppRouteNames.provider2),
      (label: l10n.provider3, routeName: AppRouteNames.provider3),
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
