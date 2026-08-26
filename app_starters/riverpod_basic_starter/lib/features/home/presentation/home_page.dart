import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basic_starter/core/router/app_router_names.dart';
import 'package:riverpod_basic_starter/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final destinations = [
      (label: l10n.items, routeName: AppRouteNames.items),
      (label: l10n.two, routeName: AppRouteNames.two),
      (label: l10n.three, routeName: AppRouteNames.three),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.title)),
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
