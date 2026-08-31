import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/providers/auth_nav_snack_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class AuthNavSnackBarListener extends ConsumerWidget {
  const AuthNavSnackBarListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authNavSnackProvider, (previous, next) {
      if (next == null) return;
      final l10n = AppLocalizations.of(context);
      final message = switch (next.kind) {
        AuthNavSnackKind.goNamed => l10n.authSnackGoNamed,
        AuthNavSnackKind.goNamedThenRedirect =>
          l10n.authSnackGoNamedThenRedirect,
        AuthNavSnackKind.redirect => l10n.authSnackRedirect,
      };
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
              duration: const Duration(milliseconds: 1500),
            ),
          );
      });
    });

    return child;
  }
}
