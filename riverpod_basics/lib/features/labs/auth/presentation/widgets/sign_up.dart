import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/providers/auth_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.signUp, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        TextField(
          key: const Key('sign-up-username'),
          controller: _usernameController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: l10n.authUsername,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          key: const Key('sign-up-password'),
          controller: _passwordController,
          obscureText: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => ref.read(authProvider.notifier).signUp(),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: l10n.authPassword,
          ),
        ),
        const SizedBox(height: 16),
        FullWidthElevatedButton(
          key: const Key('sign-up-submit'),
          label: l10n.signUp,
          onPressed: () => ref.read(authProvider.notifier).signUp(),
        ),
      ],
    );
  }
}
