import 'package:advanced_concepts/core/router/app_router_names.dart';
import 'package:advanced_concepts/features/landing/presentation/widgets/landing_list_tile.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/lab_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: LabScreenBody(
        child: ListView(
          children: [
            LandingListTile(
              label: l10n.navigation,
              onTap: () => context.pushNamed(AppRouteNames.routing),
            ),
            LandingListTile(
              label: l10n.layout,
              onTap: () => context.pushNamed(AppRouteNames.layout),
            ),
            LandingListTile(
              label: l10n.lists,
              onTap: () => context.pushNamed(AppRouteNames.lists),
            ),
          ],
        ),
      ),
    );
  }
}
