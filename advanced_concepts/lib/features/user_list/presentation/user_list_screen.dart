import 'package:advanced_concepts/core/errors/app_failure_message.dart';
import 'package:advanced_concepts/core/router/app_router_names.dart';
import 'package:advanced_concepts/core/router/nav_calls.dart';
import 'package:advanced_concepts/features/routing_lab/presentation/providers/routing_lab_provider.dart';
import 'package:advanced_concepts/features/user_list/presentation/providers/user_list_provider.dart';
import 'package:advanced_concepts/features/user_list/presentation/widgets/user_list_nav_header.dart';
import 'package:advanced_concepts/features/user_list/presentation/widgets/user_list_tile.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/error_widget.dart';
import 'package:advanced_concepts/shared_widgets/go_to_landing_button.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final users = ref.watch(userListProvider);
    final routingLab = ref.watch(routingLabProvider);
    final canPop = GoRouter.maybeOf(context)?.canPop() ?? false;
    final stackBelow =
        routingLab?.stackBelow ??
        (canPop ? NavStackBelow.routing : NavStackBelow.none);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.userList)),
      body: ListView(
        children: [
          UserListNavHeader(
            stackBelow: stackBelow,
            canPop: canPop,
            openedWith:
                routingLab?.listCall ?? (canPop ? NavCalls.push : NavCalls.go),
            onPop: () => ref
                .read(routingLabProvider.notifier)
                .tryPop(GoRouter.of(context)),
          ),
          ...users.when(
            skipLoadingOnReload: false,
            skipLoadingOnRefresh: false,
            loading: () => const [
              Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
            error: (error, _) => [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: ErrorWidget(
                  message: localizedError(l10n, error),
                  retryLabel: l10n.retry,
                  onRetry: () {
                    ref.read(userListProvider.notifier).retry();
                  },
                ),
              ),
            ],
            data: (users) => [
              for (final user in users)
                UserListTile(
                  user: user,
                  onTap: () {
                    ref
                        .read(routingLabProvider.notifier)
                        .detailsOpened(user.id);
                    context.pushNamed(
                      AppRouteNames.userDetails,
                      pathParameters: {'userId': '${user.id}'},
                    );
                  },
                ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const GoToLandingButton(),
    );
  }
}
