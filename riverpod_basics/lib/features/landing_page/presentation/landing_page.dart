import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basics/core/router/app_router_names.dart';
import 'package:riverpod_basics/features/landing_page/presentation/widgets/landing_page_dropdown.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    LandingPageDropdownItem provider({
      required String label,
      required String routeName,
    }) {
      return LandingPageDropdownItem(
        label: label,
        onTap: () => context.pushNamed(routeName),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: ListView(
        children: [
          LandingPageDropdown(
            title: l10n.providers,
            items: [
              provider(
                label: l10n.noProvider,
                routeName: AppRouteNames.noProvider,
              ),
              provider(
                label: l10n.stateProvider,
                routeName: AppRouteNames.stateProvider,
              ),
              provider(
                label: l10n.notifierProvider,
                routeName: AppRouteNames.notifierProvider,
              ),
              provider(
                label: l10n.asyncNotifierPersistentState,
                routeName: AppRouteNames.asyncNotifierPersistentState,
              ),
              provider(
                label: l10n.asyncNotifierNonPersistentState,
                routeName: AppRouteNames.asyncNotifierNonPersistentState,
              ),
            ],
          ),
          LandingPageDropdown(
            title: l10n.scenarios,
            items: [
              for (final number in [1, 2, 3])
                LandingPageDropdownItem(label: l10n.scenarioNumber(number)),
            ],
          ),
        ],
      ),
    );
  }
}
