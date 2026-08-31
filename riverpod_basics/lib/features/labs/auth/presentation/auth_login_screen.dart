import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basics/core/router/app_router_names.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/providers/auth_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

/// Username and password are unused. Submit writes the Notifier; redirect
/// uses `from` (Next Screen) or the hub.
class AuthLoginScreen extends ConsumerStatefulWidget {
  const AuthLoginScreen({super.key});

  @override
  ConsumerState<AuthLoginScreen> createState() => _AuthLoginScreenState();
}

class _AuthLoginScreenState extends ConsumerState<AuthLoginScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final from = GoRouterState.of(context)
        .uri
        .queryParameters[AuthLocations.fromQuery];
    final fromNext = from == AuthLocations.next;
    final errorColor = Theme.of(context).colorScheme.error;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.authLogin)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (fromNext) ...[
            Text(
              l10n.authUnauthorized,
              key: const Key('authUnauthorized'),
              style: TextStyle(color: errorColor),
            ),
            const SizedBox(height: 16),
          ],
          TextField(
            key: const Key('authUsername'),
            controller: _usernameController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: l10n.authUsername,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            key: const Key('authPassword'),
            controller: _passwordController,
            obscureText: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => ref.read(authProvider.notifier).login(),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: l10n.authPassword,
            ),
          ),
          const SizedBox(height: 16),
          FullWidthElevatedButton(
            key: const Key('authSubmit'),
            label: l10n.authSubmit,
            onPressed: () => ref.read(authProvider.notifier).login(),
          ),
        ],
      ),
    );
  }
}
