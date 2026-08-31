import 'package:advanced_concepts/core/router/app_router.dart';
import 'package:advanced_concepts/core/router/app_router_names.dart';
import 'package:advanced_concepts/core/router/nav_calls.dart';
import 'package:advanced_concepts/features/routing_lab/presentation/providers/routing_lab_provider.dart';
import 'package:advanced_concepts/features/routing_lab/presentation/widgets/routing_info.dart';
import 'package:advanced_concepts/features/routing_lab/presentation/widgets/routing_lab_nav_tile.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RoutingLabScreen extends ConsumerWidget {
  const RoutingLabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navigation)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const RoutingInfo(),
          const SizedBox(height: 20),
          RoutingLabNavTile(
            call: NavCalls.go,
            caption: l10n.navGoCaption,
            onTap: () {
              ref
                  .read(routingLabProvider.notifier)
                  .listOpened(UserListArrival.go, call: NavCalls.go);
              context.go(AppRoutePaths.userList);
            },
          ),
          RoutingLabNavTile(
            call: NavCalls.goNamed,
            caption: l10n.navGoNamedCaption,
            onTap: () {
              ref
                  .read(routingLabProvider.notifier)
                  .listOpened(UserListArrival.goNamed, call: NavCalls.goNamed);
              context.goNamed(AppRouteNames.userList);
            },
          ),
          RoutingLabNavTile(
            call: NavCalls.push,
            caption: l10n.navPushCaption,
            onTap: () {
              ref
                  .read(routingLabProvider.notifier)
                  .listOpened(UserListArrival.push, call: NavCalls.push);
              context.push(AppRoutePaths.userList);
            },
          ),
          RoutingLabNavTile(
            call: NavCalls.pushNamed,
            caption: l10n.navPushNamedCaption,
            onTap: () {
              ref
                  .read(routingLabProvider.notifier)
                  .listOpened(
                    UserListArrival.pushNamed,
                    call: NavCalls.pushNamed,
                  );
              context.pushNamed(AppRouteNames.userList);
            },
          ),
          RoutingLabNavTile(
            call: NavCalls.goViaRouter,
            caption: l10n.navGoViaRouterCaption,
            onTap: () {
              ref
                  .read(routingLabProvider.notifier)
                  .listOpened(UserListArrival.go, call: NavCalls.goViaRouter);
              ref.read(goRouterProvider).go(AppRoutePaths.userList);
            },
          ),
          RoutingLabNavTile(
            call: NavCalls.pushNamedViaRouter,
            caption: l10n.navPushNamedViaRouterCaption,
            onTap: () {
              ref
                  .read(routingLabProvider.notifier)
                  .listOpened(
                    UserListArrival.pushNamed,
                    call: NavCalls.pushNamedViaRouter,
                  );
              ref.read(goRouterProvider).pushNamed(AppRouteNames.userList);
            },
          ),
          RoutingLabNavTile(
            call: NavCalls.pop,
            caption: l10n.navPopCaption,
            onTap: () => ref
                .read(routingLabProvider.notifier)
                .tryPop(GoRouter.of(context)),
          ),
          RoutingLabNavTile(
            call: NavCalls.replaceNamed,
            caption: l10n.navReplaceNamedCaption,
            onTap: () {
              ref
                  .read(routingLabProvider.notifier)
                  .listOpened(
                    UserListArrival.replaceNamed,
                    call: NavCalls.replaceNamed,
                  );
              context.replaceNamed(AppRouteNames.userList);
            },
          ),
        ],
      ),
    );
  }
}
