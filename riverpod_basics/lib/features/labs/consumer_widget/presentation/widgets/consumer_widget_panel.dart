import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/consumer_widget/presentation/widgets/add_demo_user.dart';
import 'package:riverpod_basics/features/labs/consumer_widget/presentation/widgets/user_panel.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

/// Same panel as ConsumerWrapPanel, with `ref` on the widget class.
class ConsumerWidgetPanel extends ConsumerWidget {
  const ConsumerWidgetPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final listState = ref.watch(userListProvider);

    return UserPanel(
      label: l10n.consumerWidgetLabel,
      background: scheme.secondaryContainer,
      foreground: scheme.onSecondaryContainer,
      users: listState.users,
      isLoading: listState.isLoading,
      onAdd: () => addDemoUser(ref),
    );
  }
}
