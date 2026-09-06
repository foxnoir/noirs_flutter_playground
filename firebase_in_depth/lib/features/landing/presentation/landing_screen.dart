import 'package:firebase_in_depth/core/router/app_router_names.dart';
import 'package:firebase_in_depth/features/landing/presentation/widgets/landing_list_tile.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.title)),
      body: ListView(
        children: [
          LandingListTile(
            label: l10n.fundamentals,
            onTap: () => context.pushNamed(AppRouteNames.fundamentals),
          ),
        ],
      ),
    );
  }
}
