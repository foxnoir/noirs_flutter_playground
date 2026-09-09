import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:firebase_in_depth/shared_widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class AuthFormCard extends StatelessWidget {
  const AuthFormCard({
    required this.signUp,
    required this.overlapInset,
    required this.userNameController,
    required this.emailController,
    required this.passwordController,
    required this.submitting,
    required this.onSubmit,
    required this.onSwitch,
    this.error,
    super.key,
  });

  final bool signUp;
  final double overlapInset;
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String? error;
  final bool submitting;
  final VoidCallback onSubmit;
  final VoidCallback? onSwitch;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final title = signUp ? l10n.signUp : l10n.signIn;
    final line = BorderSide(color: scheme.outline);
    final linkStyle = TextButton.styleFrom(
      foregroundColor: scheme.onSurface,
      disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.5),
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    InputDecoration decoration({
      required String label,
      required IconData icon,
    }) {
      return InputDecoration(
        labelText: label,
        border: UnderlineInputBorder(borderSide: line),
        enabledBorder: UnderlineInputBorder(borderSide: line),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: scheme.primary, width: 1.4),
        ),
        suffixIcon: Icon(icon, color: scheme.onSurfaceVariant),
      );
    }

    return DecoratedBox(
      key: const Key('auth-card'),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.7)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          signUp ? 28 : 24 + overlapInset,
          25,
          signUp ? 24 + overlapInset : 28,
          21,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: textTheme.titleLarge),
            const SizedBox(height: 20),
            if (signUp) ...[
              TextField(
                key: const Key('auth-username'),
                controller: userNameController,
                enabled: !submitting,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.username],
                decoration: decoration(
                  label: l10n.authUserName,
                  icon: Icons.person_outline,
                ),
              ),
              const SizedBox(height: 12),
            ],
            TextField(
              key: const Key('auth-email'),
              controller: emailController,
              enabled: !submitting,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              textInputAction: TextInputAction.next,
              decoration: decoration(
                label: l10n.authEmail,
                icon: Icons.mail_outline,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('auth-password'),
              controller: passwordController,
              enabled: !submitting,
              obscureText: true,
              autofillHints: signUp
                  ? const [AutofillHints.newPassword]
                  : const [AutofillHints.password],
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => onSubmit(),
              decoration: decoration(
                label: l10n.authPassword,
                icon: Icons.lock_outline,
              ),
            ),
            if (error != null) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  error!,
                  key: const Key('auth-error'),
                  style: textTheme.bodySmall?.copyWith(color: scheme.error),
                ),
              ),
            ],
            const SizedBox(height: 24),
            GradientButton.primary(
              key: const Key('auth-submit'),
              label: title,
              expanded: true,
              pill: true,
              onPressed: submitting ? null : onSubmit,
            ),
            const SizedBox(height: 16),
            if (signUp)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  key: const Key('auth-switch-mode'),
                  style: linkStyle,
                  onPressed: onSwitch,
                  child: Text(l10n.authHaveAccount),
                ),
              )
            else
              Row(
                children: [
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        key: const Key('auth-switch-mode'),
                        style: linkStyle,
                        onPressed: onSwitch,
                        child: Text(
                          l10n.authNeedAccount,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        key: const Key('auth-forgot-password'),
                        style: linkStyle,
                        onPressed: () {},
                        child: Text(
                          l10n.authForgotPassword,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
