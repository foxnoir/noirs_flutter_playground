import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basic_starter/core/router/app_router_names.dart';
import 'package:riverpod_basic_starter/core/router/page_not_found_screen.dart';
import 'package:riverpod_basic_starter/core/router/placeholder_screen.dart';
import 'package:riverpod_basic_starter/features/detail/presentation/detail_screen.dart';
import 'package:riverpod_basic_starter/features/home/presentation/home_page.dart';
import 'package:riverpod_basic_starter/l10n/app_localizations.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutePaths.home,
    errorBuilder: (context, state) => const PageNotFoundScreen(),
    routes: [
      GoRoute(
        path: AppRoutePaths.home,
        name: AppRouteNames.home,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: AppRoutePaths.one,
            name: AppRouteNames.one,
            builder: (context, state) => const DetailScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.two,
            name: AppRouteNames.two,
            builder: (context, state) {
              final l10n = AppLocalizations.of(context);
              return PlaceholderScreen(title: l10n.two);
            },
          ),
          GoRoute(
            path: AppRoutePaths.three,
            name: AppRouteNames.three,
            builder: (context, state) {
              final l10n = AppLocalizations.of(context);
              return PlaceholderScreen(title: l10n.three);
            },
          ),
        ],
      ),
    ],
  );
});
