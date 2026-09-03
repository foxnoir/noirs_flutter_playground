import 'package:advanced_concepts/core/errors/app_failure.dart';
import 'package:advanced_concepts/features/api_lab_session/presentation/widgets/api_lab_login_dialog.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Shows the lab login warning when DELETE returned 401.
/// Returns `true` if this was unauthorized (caller should stop).
///
/// Pass [replaceCurrentDialog] from a confirm dialog so that route is
/// removed instead of sitting under this one.
Future<bool> showUnauthorizedIfNeeded(
  BuildContext context,
  Object error, {
  bool replaceCurrentDialog = false,
}) async {
  if (AppFailure.from(error) is! UnauthorizedFailure) {
    return false;
  }
  await showApiLabUnauthorizedDialog(
    context,
    replaceCurrentDialog: replaceCurrentDialog,
  );
  return true;
}

Future<void> showApiLabUnauthorizedDialog(
  BuildContext context, {
  bool replaceCurrentDialog = false,
}) {
  final navigator = Navigator.of(context);
  final route = DialogRoute<void>(
    context: context,
    builder: (context) => const ApiLabUnauthorizedDialog(),
  );
  if (replaceCurrentDialog) {
    return navigator.pushReplacement(route);
  }
  return navigator.push(route);
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
          onPressed: () {
            showApiLabLoginDialog(context, replaceCurrentDialog: true);
          },
          child: Text(l10n.apiLabLogin),
        ),
      ],
    );
  }
}
