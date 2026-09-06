import 'package:firebase_in_depth/core/router/app_router_names.dart';
import 'package:firebase_in_depth/core/router/page_not_found_screen.dart';
import 'package:firebase_in_depth/core/router/placeholder_screen.dart';
import 'package:firebase_in_depth/features/home/presentation/home_screen.dart';
import 'package:firebase_in_depth/features/item_details/presentation/item_details_screen.dart';
import 'package:firebase_in_depth/features/items/presentation/items_screen.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutePaths.home,
    errorBuilder: (context, state) => const PageNotFoundScreen(),
    routes: [
      GoRoute(
        path: AppRoutePaths.home,
        name: AppRouteNames.home,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: AppRoutePaths.items,
            name: AppRouteNames.items,
            builder: (context, state) => const ItemsScreen(),
            routes: [
              GoRoute(
                path: AppRoutePaths.itemDetails,
                name: AppRouteNames.itemDetails,
                builder: (context, state) {
                  final id = int.tryParse(state.pathParameters['itemId'] ?? '');
                  if (id == null) {
                    return const PageNotFoundScreen();
                  }
                  return ItemDetailsScreen(id: id);
                },
              ),
            ],
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
