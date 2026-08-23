import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basics/core/router/app_router_names.dart';
import 'package:riverpod_basics/core/router/page_not_found_screen.dart';
import 'package:riverpod_basics/core/router/placeholder_screen.dart';
import 'package:riverpod_basics/features/counter_state/presentation/counter_screen.dart';
import 'package:riverpod_basics/features/landing_page/presentation/landing_page.dart';
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
            path: 'counter',
            name: AppRouteNames.counter,
            builder: (context, state) => const CounterScreen(),
          ),
          GoRoute(
            path: 'provider-2',
            name: AppRouteNames.provider2,
            builder: (context, state) => PlaceholderScreen(
              title: AppLocalizations.of(context).provider2,
            ),
          ),
          GoRoute(
            path: 'provider-3',
            name: AppRouteNames.provider3,
            builder: (context, state) => PlaceholderScreen(
              title: AppLocalizations.of(context).provider3,
            ),
          ),
        ],
      ),
    ],
  );
});
