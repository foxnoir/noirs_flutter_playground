import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basics/core/router/app_router_names.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/providers/auth_nav_snack_provider.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/providers/auth_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';
import 'package:riverpod_basics/shared_widgets/lab_info_text.dart';

/// Public hub. Login and Next Screen are nested routes.
class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final loggedIn = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.auth)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          LabInfoText(l10n.authBody),
          const SizedBox(height: 16),
          FullWidthElevatedButton(
            key: const Key('authLogin'),
            label: l10n.authLogin,
            onPressed: loggedIn
                ? null
                : () {
                    ref.read(authNavSnackProvider.notifier).markGoNamed();
                    context.goNamed(AppRouteNames.authLogin);
                    ref
                        .read(authNavSnackProvider.notifier)
                        .flushIfGoNamedOnly();
                  },
          ),
          const SizedBox(height: 12),
          FullWidthElevatedButton(
            key: const Key('authLogout'),
            label: l10n.authLogout,
            onPressed: loggedIn
                ? () => ref.read(authProvider.notifier).logout()
                : null,
          ),
          const SizedBox(height: 12),
          FullWidthElevatedButton(
            key: const Key('authNext'),
            label: l10n.authNextScreen,
            onPressed: () {
              ref.read(authNavSnackProvider.notifier).markGoNamed();
              context.goNamed(AppRouteNames.authNext);
              ref.read(authNavSnackProvider.notifier).flushIfGoNamedOnly();
            },
          ),
        ],
      ),
    );
  }
}
