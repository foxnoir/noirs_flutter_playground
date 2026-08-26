import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/consumer_widget/presentation/widgets/add_demo_user.dart';
import 'package:riverpod_basics/features/labs/consumer_widget/presentation/widgets/user_panel.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

/// Course shape: `StatelessWidget` plus a `Consumer` wrapper for `ref`.
class ConsumerWrapPanel extends StatelessWidget {
  const ConsumerWrapPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Consumer(
      builder: (context, ref, _) {
        final listState = ref.watch(userListProvider);
        return UserPanel(
          label: l10n.consumerWrapLabel,
          background: scheme.primaryContainer,
          foreground: scheme.onPrimaryContainer,
          users: listState.users,
          isLoading: listState.isLoading,
          onAdd: () => addDemoUser(ref),
        );
      },
    );
  }
}
