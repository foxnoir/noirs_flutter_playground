import 'package:advanced_concepts/core/errors/app_failure_message.dart';
import 'package:advanced_concepts/core/router/app_router_calls.dart';
import 'package:advanced_concepts/features/routing_lab/presentation/providers/routing_lab_provider.dart';
import 'package:advanced_concepts/features/user_details/presentation/providers/user_details_provider.dart';
import 'package:advanced_concepts/features/user_details/presentation/widgets/user_details_body.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:advanced_concepts/shared_widgets/error_widget.dart';
import 'package:advanced_concepts/shared_widgets/go_to_landing_button.dart';
import 'package:advanced_concepts/shared_widgets/nav_stack_preview.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetailsScreen extends ConsumerWidget {
  const UserDetailsScreen({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(userDetailsProvider(id));

    final stackBelow = ref.watch(
      routingLabProvider.select((s) => s?.stackBelow ?? NavStackBelow.none),
    );
    final nickname = user.asData?.value.nickname;

    return Scaffold(
      appBar: AppBar(title: Text(nickname ?? l10n.userDetails)),
      body: user.when(
        skipLoadingOnReload: false,
        skipLoadingOnRefresh: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: ErrorWidget(
            message: localizedError(l10n, error),
            retryLabel: l10n.retry,
            onRetry: () {
              ref.read(userDetailsProvider(id).notifier).retry();
            },
          ),
        ),
        data: (user) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            NavStackPreview(
              frames: [
                user.nickname,
                l10n.userList,
                if (stackBelow == NavStackBelow.routing) l10n.routing,
                if (stackBelow == NavStackBelow.landing) l10n.landing,
              ],
              footer: switch (stackBelow) {
                NavStackBelow.none => l10n.stackRoutingReplaced,
                NavStackBelow.landing => l10n.stackReplaceKeptLanding,
                NavStackBelow.routing => null,
              },
            ),
            const SizedBox(height: 12),
            Text(
              l10n.openedWith,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 4),
            CodeSnippet(AppRouterCalls.userDetails(id)),
            const SizedBox(height: 16),
            UserDetailsBody(user: user),
          ],
        ),
      ),
      bottomNavigationBar: const GoToLandingButton(),
    );
  }
}
