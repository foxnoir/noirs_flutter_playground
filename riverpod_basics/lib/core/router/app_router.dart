import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basics/core/router/app_router_names.dart';
import 'package:riverpod_basics/core/router/page_not_found_screen.dart';
import 'package:riverpod_basics/core/router/placeholder_screen.dart';
import 'package:riverpod_basics/features/landing_page/presentation/landing_page.dart';
import 'package:riverpod_basics/features/no_provider/presentation/no_provider_screen.dart';
import 'package:riverpod_basics/features/state_provider/presentation/state_provider_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutePaths.landing,
    errorBuilder: (context, state) => const PageNotFoundScreen(),
    routes: [
      GoRoute(
        path: AppRoutePaths.landing,
        name: AppRouteNames.landing,
        builder: (context, state) => const LandingPage(),
        routes: [
          GoRoute(
            path: AppRoutePaths.noProvider,
            name: AppRouteNames.noProvider,
            builder: (context, state) => const NoProviderScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.stateProvider,
            name: AppRouteNames.stateProvider,
            builder: (context, state) => const StateProviderScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.provider2,
            name: AppRouteNames.provider2,
            builder: (context, state) {
              final l10n = AppLocalizations.of(context);
              return PlaceholderScreen(title: l10n.provider2);
            },
          ),
          GoRoute(
            path: AppRoutePaths.provider3,
            name: AppRouteNames.provider3,
            builder: (context, state) {
              final l10n = AppLocalizations.of(context);
              return PlaceholderScreen(title: l10n.provider3);
            },
          ),
        ],
      ),
    ],
  );
});
