import 'package:firebase_in_depth/core/router/app_router_names.dart';
import 'package:firebase_in_depth/core/router/page_not_found_screen.dart';
import 'package:firebase_in_depth/features/auth/presentation/auth_screen.dart';
import 'package:firebase_in_depth/features/auth/presentation/providers/auth_provider.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/course_lab_screen.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/firebase_fundamentals_screen.dart';
import 'package:firebase_in_depth/features/landing/presentation/landing_screen.dart';
import 'package:firebase_in_depth/features/my_courses/presentation/my_courses_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: AppRoutePaths.landing,
    errorBuilder: (context, state) => const PageNotFoundScreen(),
    redirect: (context, state) {
      final session = ref.read(authProvider);
      final onMyCourses = state.uri.path == '/${AppRoutePaths.myCourses}';
      if (onMyCourses && session == null) {
        return '/${AppRoutePaths.login}';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutePaths.landing,
        name: AppRouteNames.landing,
        builder: (context, state) => const LandingScreen(),
        routes: [
          GoRoute(
            path: AppRoutePaths.home,
            name: AppRouteNames.home,
            builder: (context, state) => const CourseLabScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.fundamentals,
            name: AppRouteNames.fundamentals,
            builder: (context, state) {
              return const FirebaseFundamentalsScreen();
            },
          ),
          GoRoute(
            path: AppRoutePaths.myCourses,
            name: AppRouteNames.myCourses,
            builder: (context, state) => const MyCoursesScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.login,
            name: AppRouteNames.login,
            builder: (context, state) => const AuthScreen(),
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
