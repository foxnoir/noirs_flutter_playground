import 'package:advanced_concepts/core/router/app_router_names.dart';
import 'package:advanced_concepts/features/landing/presentation/widgets/landing_list_tile.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/lab_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ApiHandlingScreen extends StatelessWidget {
  const ApiHandlingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.apiHandling)),
      body: LabScreenBody(
        child: ListView(
          children: [
            LandingListTile(
              label: l10n.apiGeneral,
              onTap: () => context.pushNamed(AppRouteNames.apiGeneral),
            ),
            LandingListTile(
              label: l10n.apiHttp,
              onTap: () => context.pushNamed(AppRouteNames.apiHttp),
            ),
            LandingListTile(
              label: l10n.apiDio,
              onTap: () => context.pushNamed(AppRouteNames.apiDio),
            ),
          ],
        ),
      ),
    );
  }
}
