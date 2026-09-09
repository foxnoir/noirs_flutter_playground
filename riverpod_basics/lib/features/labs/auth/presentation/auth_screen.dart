import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basics/core/router/app_router_names.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/providers/auth_nav_snack_provider.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/providers/auth_provider.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/widgets/sign_in.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/widgets/sign_up.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';
import 'package:riverpod_basics/shared_widgets/lab_info_text.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final signedIn = ref.watch(authProvider);
    final fromProtected =
        GoRouterState.of(context)
            .uri
            .queryParameters[AuthLocations.fromQuery] ==
        AuthLocations.protected;
    final errorColor = Theme.of(context).colorScheme.error;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.auth)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          LabInfoText(l10n.authBody),
          const SizedBox(height: 16),
          if (!signedIn && fromProtected) ...[
            Text(
              l10n.authUnauthorized,
              key: const Key('unauthorized'),
              style: TextStyle(color: errorColor),
            ),
            const SizedBox(height: 16),
          ],
          if (!signedIn) ...[
            Text(l10n.authCredentialsHint),
            const SizedBox(height: 16),
            const SignIn(),
            const SizedBox(height: 24),
            const SignUp(),
            const SizedBox(height: 24),
          ] else ...[
            FullWidthElevatedButton(
              key: const Key('sign-out'),
              label: l10n.signOut,
              onPressed: () => ref.read(authProvider.notifier).signOut(),
            ),
            const SizedBox(height: 12),
          ],
          FullWidthElevatedButton(
            key: const Key('protected'),
            label: l10n.authProtected,
            onPressed: () {
              ref.read(authNavSnackProvider.notifier).markGoNamed();
              context.goNamed(AppRouteNames.authProtected);
              ref.read(authNavSnackProvider.notifier).flushIfGoNamedOnly();
            },
          ),
        ],
      ),
    );
  }
}
