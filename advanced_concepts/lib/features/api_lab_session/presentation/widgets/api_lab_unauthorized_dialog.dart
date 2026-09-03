import 'package:advanced_concepts/features/api_lab_session/presentation/providers/api_lab_session_provider.dart';
import 'package:advanced_concepts/features/api_lab_session/presentation/widgets/api_lab_login_dialog.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// `true` only when already authorized. Login never finishes the DELETE.
Future<bool> isAuthorized(BuildContext context, WidgetRef ref) async {
  if (ref.read(apiLabSessionProvider)) {
    return true;
  }
  await showApiLabUnauthorizedDialog(context);
  return false;
}

Future<void> showApiLabUnauthorizedDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => const ApiLabUnauthorizedDialog(),
  );
}

class ApiLabUnauthorizedDialog extends StatelessWidget {
  const ApiLabUnauthorizedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;

    return AlertDialog(
      backgroundColor: colors.errorContainer,
      icon: Icon(Icons.error_outline, color: colors.error, size: 36),
      title: Text(
        l10n.apiLabUnauthorizedTitle,
        style: TextStyle(color: colors.onErrorContainer),
      ),
      content: Text(
        l10n.apiLabUnauthorizedBody,
        style: TextStyle(color: colors.onErrorContainer),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(foregroundColor: colors.onErrorContainer),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        FilledButton(
          key: const Key('api-lab-unauthorized-login'),
          style: FilledButton.styleFrom(
            backgroundColor: colors.error,
            foregroundColor: colors.onError,
          ),
          onPressed: () async {
            final loggedIn = await showApiLabLoginDialog(context);
            if (loggedIn && context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: Text(l10n.apiLabLogin),
        ),
      ],
    );
  }
}
