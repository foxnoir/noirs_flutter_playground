import 'package:advanced_concepts/features/api_lab_session/presentation/api_lab_login_validator.dart';
import 'package:advanced_concepts/features/api_lab_session/presentation/providers/api_lab_session_provider.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Returns `true` after a valid form submit. Does not check credentials.
///
/// Pass [replaceCurrentDialog] from the unauthorized warning so that
/// route is removed instead of sitting under this one.
Future<bool> showApiLabLoginDialog(
  BuildContext context, {
  bool replaceCurrentDialog = false,
}) async {
  final navigator = Navigator.of(context);
  final route = DialogRoute<bool>(
    context: context,
    builder: (context) => const ApiLabLoginDialog(),
  );
  final loggedIn = replaceCurrentDialog
      ? await navigator.pushReplacement(route)
      : await navigator.push(route);
  return loggedIn ?? false;
}

class ApiLabLoginDialog extends ConsumerStatefulWidget {
  const ApiLabLoginDialog({super.key});

  @override
  ConsumerState<ApiLabLoginDialog> createState() => _ApiLabLoginDialogState();
}

class _ApiLabLoginDialogState extends ConsumerState<ApiLabLoginDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    ref.read(apiLabSessionProvider.notifier).logIn();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).apiLabSnackLoggedIn),
        ),
      );
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final validator = ApiLabLoginValidator(l10n);

    return AlertDialog(
      title: Text(l10n.apiLabLoginTitle),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                key: const Key('api-lab-login-email'),
                controller: _email,
                autofillHints: const [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: l10n.email),
                validator: validator.email,
              ),
              const SizedBox(height: 8),
              TextFormField(
                key: const Key('api-lab-login-password'),
                controller: _password,
                autofillHints: const [AutofillHints.password],
                obscureText: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
                decoration: InputDecoration(labelText: l10n.apiLabPassword),
                validator: validator.password,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        FilledButton(
          key: const Key('api-lab-login-submit'),
          onPressed: _submit,
          child: Text(l10n.apiLabLogin),
        ),
      ],
    );
  }
}
