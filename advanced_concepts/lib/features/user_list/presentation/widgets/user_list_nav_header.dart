import 'package:advanced_concepts/core/router/nav_calls.dart';
import 'package:advanced_concepts/features/routing_lab/presentation/providers/routing_lab_provider.dart';
import 'package:advanced_concepts/features/routing_lab/presentation/widgets/routing_nav_tile.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:advanced_concepts/shared_widgets/nav_stack_preview.dart';
import 'package:flutter/material.dart';

class UserListNavHeader extends StatelessWidget {
  const UserListNavHeader({
    required this.stackBelow,
    required this.canPop,
    required this.openedWith,
    required this.onPop,
    super.key,
  });

  final NavStackBelow stackBelow;
  final bool canPop;
  final String openedWith;
  final VoidCallback onPop;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NavStackPreview(
            frames: [
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
          Text(l10n.openedWith, style: textTheme.labelMedium),
          const SizedBox(height: 4),
          CodeSnippet(openedWith),
          const SizedBox(height: 8),
          Text(_canPopCopy(l10n), style: textTheme.bodySmall),
          const SizedBox(height: 8),
          RoutingNavTile(
            call: NavCalls.pop,
            caption: canPop
                ? l10n.userListPopCaptionCan
                : l10n.userListPopCaptionCannot,
            onTap: onPop,
          ),
          const SizedBox(height: 8),
          Text(l10n.userListOpenDetails, style: textTheme.labelMedium),
        ],
      ),
    );
  }

  String _canPopCopy(AppLocalizations l10n) {
    return switch (stackBelow) {
      NavStackBelow.routing => l10n.userListCanPopTrue,
      NavStackBelow.landing => l10n.userListCanPopReplace,
      NavStackBelow.none => l10n.userListCanPopFalse,
    };
  }
}
