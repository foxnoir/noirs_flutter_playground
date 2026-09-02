import 'package:advanced_concepts/core/router/app_router_names.dart';
import 'package:advanced_concepts/core/router/not_found_screen.dart';
import 'package:advanced_concepts/features/api_compare_lab/presentation/api_compare_lab_screen.dart';
import 'package:advanced_concepts/features/api_dio_lab/presentation/api_dio_lab_screen.dart';
import 'package:advanced_concepts/features/api_general_lab/presentation/api_general_lab_screen.dart';
import 'package:advanced_concepts/features/api_handling/presentation/api_handling_screen.dart';
import 'package:advanced_concepts/features/api_http_lab/presentation/api_http_lab_screen.dart';
import 'package:advanced_concepts/features/book_details/presentation/book_details_screen.dart';
import 'package:advanced_concepts/features/landing/presentation/landing_screen.dart';
import 'package:advanced_concepts/features/layout_lab/presentation/layout_lab_screen.dart';
import 'package:advanced_concepts/features/lists_lab/presentation/lists_lab_screen.dart';
import 'package:advanced_concepts/features/routing_lab/presentation/routing_lab_screen.dart';
import 'package:advanced_concepts/features/user_details/presentation/user_details_screen.dart';
import 'package:advanced_concepts/features/user_list/presentation/user_list_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: AppRoutePaths.landing,
    errorBuilder: (context, state) => const NotFoundScreen(),
    routes: [
      GoRoute(
        path: AppRoutePaths.landing,
        name: AppRouteNames.landing,
        builder: (context, state) => const LandingScreen(),
        routes: [
          GoRoute(
            path: AppRoutePaths.routing,
            name: AppRouteNames.routing,
            builder: (context, state) => const RoutingLabScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.layout,
            name: AppRouteNames.layout,
            builder: (context, state) => const LayoutLabScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.lists,
            name: AppRouteNames.lists,
            builder: (context, state) => const ListsLabScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.apiHandling,
            name: AppRouteNames.apiHandling,
            builder: (context, state) => const ApiHandlingScreen(),
            routes: [
              GoRoute(
                path: AppRoutePaths.apiGeneral,
                name: AppRouteNames.apiGeneral,
                builder: (context, state) => const ApiGeneralLabScreen(),
              ),
              GoRoute(
                path: AppRoutePaths.apiCompare,
                name: AppRouteNames.apiCompare,
                builder: (context, state) => const ApiCompareLabScreen(),
              ),
              GoRoute(
                path: AppRoutePaths.apiHttp,
                name: AppRouteNames.apiHttp,
                builder: (context, state) => const ApiHttpLabScreen(),
                routes: [
                  GoRoute(
                    path: AppRoutePaths.bookDetails,
                    name: AppRouteNames.httpBookDetails,
                    builder: (context, state) {
                      final extra = state.extra;
                      return BookDetailsScreen(
                        bookId: state.pathParameters['bookId'] ?? '',
                        title: extra is String ? extra : null,
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: AppRoutePaths.apiDio,
                name: AppRouteNames.apiDio,
                builder: (context, state) => const ApiDioLabScreen(),
                routes: [
                  GoRoute(
                    path: AppRoutePaths.bookDetails,
                    name: AppRouteNames.bookDetails,
                    builder: (context, state) {
                      final extra = state.extra;
                      return BookDetailsScreen(
                        bookId: state.pathParameters['bookId'] ?? '',
                        title: extra is String ? extra : null,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutePaths.userList,
        name: AppRouteNames.userList,
        builder: (context, state) => const UserListScreen(),
        routes: [
          GoRoute(
            path: AppRoutePaths.userDetails,
            name: AppRouteNames.userDetails,
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['userId'] ?? '');
              if (id == null) {
                return const NotFoundScreen();
              }
              return UserDetailsScreen(id: id);
            },
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
