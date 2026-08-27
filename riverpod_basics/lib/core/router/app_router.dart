import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basics/core/router/app_router_names.dart';
import 'package:riverpod_basics/core/router/page_not_found_screen.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/add_user_screen.dart';
import 'package:riverpod_basics/features/labs/consumer_widget/presentation/consumer_widget_screen.dart';
import 'package:riverpod_basics/features/labs/listen_manual/presentation/listen_manual_screen.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/provider_lifetimes_screen.dart';
import 'package:riverpod_basics/features/labs/quote/presentation/quote_screen.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/refresh_screen.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/user_list_screen.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/user_search_screen.dart';
import 'package:riverpod_basics/features/landing_page/presentation/landing_page.dart';
import 'package:riverpod_basics/features/providers/async_notifier_non_persistent_state/presentation/async_notifier_non_persistent_state_screen.dart';
import 'package:riverpod_basics/features/providers/async_notifier_persistent_state/presentation/async_notifier_persistent_state_screen.dart';
import 'package:riverpod_basics/features/providers/no_provider/presentation/no_provider_screen.dart';
import 'package:riverpod_basics/features/providers/notifier_provider/presentation/notifier_provider_screen.dart';
import 'package:riverpod_basics/features/providers/state_provider/presentation/state_provider_screen.dart';

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
            path: AppRoutePaths.refresh,
            name: AppRouteNames.refresh,
            builder: (context, state) => const RefreshScreen(),
          ),
        ],
      ),
    ],
  );
});
