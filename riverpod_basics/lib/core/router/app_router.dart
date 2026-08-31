import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basics/core/router/app_router_names.dart';
import 'package:riverpod_basics/core/router/page_not_found_screen.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/add_user_screen.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/auth_login_screen.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/auth_next_screen.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/auth_screen.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/providers/auth_nav_snack_provider.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/providers/auth_provider.dart';
import 'package:riverpod_basics/features/labs/consumer_widget/presentation/consumer_widget_screen.dart';
import 'package:riverpod_basics/features/labs/listen_manual/presentation/listen_manual_screen.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/provider_lifetimes_screen.dart';
import 'package:riverpod_basics/features/labs/quote/presentation/quote_screen.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/refresh_screen.dart';
import 'package:riverpod_basics/features/labs/tick/presentation/tick_screen.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/user_list_screen.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/user_search_screen.dart';
import 'package:riverpod_basics/features/landing_page/presentation/landing_page.dart';
import 'package:riverpod_basics/features/providers/async_notifier_non_persistent_state/presentation/async_notifier_non_persistent_state_screen.dart';
import 'package:riverpod_basics/features/providers/async_notifier_persistent_state/presentation/async_notifier_persistent_state_screen.dart';
import 'package:riverpod_basics/features/providers/no_provider/presentation/no_provider_screen.dart';
import 'package:riverpod_basics/features/providers/notifier_provider/presentation/notifier_provider_screen.dart';
import 'package:riverpod_basics/features/providers/state_provider/presentation/state_provider_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  // Do not ref.watch(authProvider) here — that would build a new GoRouter
  // on every login and drop the stack. Listen + refreshListenable re-runs
  // redirect on the same instance (go_router 17).
  final refresh = ValueNotifier<int>(0);
  ref.onDispose(refresh.dispose);

  final router = GoRouter(
    initialLocation: AppRoutePaths.landing,
    errorBuilder: (context, state) => const PageNotFoundScreen(),
    refreshListenable: refresh,
    redirect: (_, state) => _authRedirect(ref, state),
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
            path: AppRoutePaths.notifierProvider,
            name: AppRouteNames.notifierProvider,
            builder: (context, state) => const NotifierProviderScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.asyncNotifierPersistentState,
            name: AppRouteNames.asyncNotifierPersistentState,
            builder: (context, state) =>
                const AsyncNotifierPersistentStateScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.asyncNotifierNonPersistentState,
            name: AppRouteNames.asyncNotifierNonPersistentState,
            builder: (context, state) =>
                const AsyncNotifierNonPersistentStateScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.providerLifetimes,
            name: AppRouteNames.providerLifetimes,
            builder: (context, state) => const ProviderLifetimesScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.addUser,
            name: AppRouteNames.addUser,
            builder: (context, state) => const AddUserScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.userList,
            name: AppRouteNames.userList,
            builder: (context, state) => const UserListScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.userSearch,
            name: AppRouteNames.userSearch,
            builder: (context, state) => const UserSearchScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.listenManual,
            name: AppRouteNames.listenManual,
            builder: (context, state) => const ListenManualScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.consumerWidget,
            name: AppRouteNames.consumerWidget,
            builder: (context, state) => const ConsumerWidgetScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.quote,
            name: AppRouteNames.quote,
            builder: (context, state) => const QuoteScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.tick,
            name: AppRouteNames.tick,
            builder: (context, state) => const TickScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.refresh,
            name: AppRouteNames.refresh,
            builder: (context, state) => const RefreshScreen(),
          ),
          GoRoute(
            path: AppRoutePaths.auth,
            name: AppRouteNames.auth,
            builder: (context, state) => const AuthScreen(),
            routes: [
              GoRoute(
                path: AppRoutePaths.authLogin,
                name: AppRouteNames.authLogin,
                builder: (context, state) => const AuthLoginScreen(),
              ),
              GoRoute(
                path: AppRoutePaths.authNext,
                name: AppRouteNames.authNext,
                builder: (context, state) => const AuthNextScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
  ref
    ..listen(authProvider, (_, _) {
      refresh.value++;
      router.refresh();
    })
    ..onDispose(router.dispose);
  return router;
});

String? _authRedirect(Ref ref, GoRouterState state) {
  final loggedIn = ref.read(authProvider);
  final location = state.uri.path;
  if (location == AuthLocations.next && !loggedIn) {
    ref.read(authNavSnackProvider.notifier).emitRedirect();
    return Uri(
      path: AuthLocations.login,
      queryParameters: {AuthLocations.fromQuery: AuthLocations.next},
    ).toString();
  }
  if (location == AuthLocations.login && loggedIn) {
    ref.read(authNavSnackProvider.notifier).emitRedirect();
    final from = state.uri.queryParameters[AuthLocations.fromQuery];
    if (from == AuthLocations.next) {
      return AuthLocations.next;
    }
    return AuthLocations.hub;
  }
  return null;
}
