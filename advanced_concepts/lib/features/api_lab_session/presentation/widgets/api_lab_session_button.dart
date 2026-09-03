import 'package:advanced_concepts/features/api_lab_session/presentation/providers/api_lab_session_provider.dart';
import 'package:advanced_concepts/features/api_lab_session/presentation/widgets/api_lab_login_dialog.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// AppBar lock: outline when logged out, open + teal when authorized.
class ApiLabSessionButton extends ConsumerWidget {
  const ApiLabSessionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final authorized = ref.watch(apiLabSessionProvider);
    final colors = Theme.of(context).colorScheme;

    return IconButton(
      key: const Key('api-lab-session'),
      tooltip: authorized ? l10n.apiLabLoggedIn : l10n.apiLabLoggedOut,
      onPressed: () {
        if (authorized) return;
        showApiLabLoginDialog(context);
      },
      icon: Icon(
        authorized ? Icons.lock_open : Icons.lock_outline,
        color: authorized
            ? colors.tertiaryContainer
            : colors.onPrimaryContainer,
      ),
    );
  }
}
