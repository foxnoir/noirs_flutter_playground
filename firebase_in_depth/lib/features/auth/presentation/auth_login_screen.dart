import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/core/errors/app_failure_message.dart';
import 'package:firebase_in_depth/core/router/app_router_names.dart';
import 'package:firebase_in_depth/core/theme/app_breakpoint.dart';
import 'package:firebase_in_depth/features/auth/presentation/providers/auth_provider.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:firebase_in_depth/shared_widgets/desktop_scaffold.dart';
import 'package:firebase_in_depth/shared_widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthLoginScreen extends ConsumerStatefulWidget {
  const AuthLoginScreen({super.key});

  static const dragonAsset = 'assets/img/auth_dragon.png';

  @override
  ConsumerState<AuthLoginScreen> createState() => _AuthLoginScreenState();
}

class _AuthLoginScreenState extends ConsumerState<AuthLoginScreen> {
  late final TextEditingController _userNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  var _signUp = false;
  var _modeFromRoute = false;
  var _submitting = false;
  String? _error;

  static const _swapDuration = Duration(milliseconds: 520);

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_modeFromRoute) return;
    _modeFromRoute = true;
    if (GoRouter.maybeOf(context) == null) return;
    _signUp =
        GoRouterState.of(
          context,
        ).uri.queryParameters[AppRoutePaths.loginMode] ==
        AppRoutePaths.signUpMode;
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty || _submitting) return;

    setState(() {
      _submitting = true;
      _error = null;
    });

    final l10n = AppLocalizations.of(context);
    try {
      final notifier = ref.read(authProvider.notifier);
      if (_signUp) {
        await notifier.signUp(email: email, password: password);
      } else {
        await notifier.signIn(email: email, password: password);
      }
      if (!context.mounted) return;
      if (context.canPop()) {
        context.pop();
      } else {
        context.goNamed(AppRouteNames.landing);
      }
    } on AppFailure catch (failure) {
      if (!context.mounted) return;
      setState(() {
        _error = _signUp && failure is AuthFailure
            ? l10n.authSignUpFailed
            : failure.message(l10n);
        _submitting = false;
      });
    } catch (_) {
      if (!context.mounted) return;
      setState(() {
        _error = _signUp ? l10n.authSignUpFailed : l10n.authSignInFailed;
        _submitting = false;
      });
    }
  }

  void _toggleMode() {
    setState(() {
      _signUp = !_signUp;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DesktopScaffold(
      currentRoute: AppRouteNames.login,
      body: Align(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 920),
            child: _AuthSplitCard(
              signUp: _signUp,
              userNameController: _userNameController,
              emailController: _emailController,
              passwordController: _passwordController,
              error: _error,
              submitting: _submitting,
              swapDuration: _swapDuration,
              onSubmit: _submit,
              onSwitch: _submitting ? null : _toggleMode,
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthSplitCard extends StatelessWidget {
  const _AuthSplitCard({
    required this.signUp,
    required this.userNameController,
    required this.emailController,
    required this.passwordController,
    required this.submitting,
    required this.swapDuration,
    required this.onSubmit,
    required this.onSwitch,
    this.error,
  });

  final bool signUp;
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String? error;
  final bool submitting;
  final Duration swapDuration;
  final VoidCallback onSubmit;
  final VoidCallback? onSwitch;

  static const _stackHeight = 580.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < AppBreakpoint.mediumMin;
        final width = constraints.maxWidth;
        final dragonWidth = compact ? width : width * 0.61;
        final formWidth = compact ? width : width * 0.47;
        final overlap = compact ? 0.0 : dragonWidth + formWidth - width;
        final form = _AuthFormCard(
          signUp: signUp,
          overlapInset: overlap,
          userNameController: userNameController,
          emailController: emailController,
          passwordController: passwordController,
          error: error,
          submitting: submitting,
          onSubmit: onSubmit,
          onSwitch: onSwitch,
        );
        final dragon = _AuthDragonPanel(compact: compact);

        if (compact) {
          return Column(
            children: [
              if (!signUp) ...[dragon, const SizedBox(height: 16)],
              form,
              if (signUp) ...[const SizedBox(height: 16), dragon],
            ],
          );
        }

        final dragonLeft = signUp ? width - dragonWidth : 0.0;
        final formLeft = signUp ? 0.0 : dragonWidth - overlap;

        return SizedBox(
          height: _stackHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedPositioned(
                duration: swapDuration,
                curve: Curves.easeInOutCubic,
                left: formLeft,
                top: 0,
                bottom: 0,
                width: formWidth,
                child: Center(child: form),
              ),
              AnimatedPositioned(
                duration: swapDuration,
                curve: Curves.easeInOutCubic,
                left: dragonLeft,
                top: 0,
                width: dragonWidth,
                height: _stackHeight,
                child: dragon,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AuthDragonPanel extends StatelessWidget {
  const _AuthDragonPanel({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scheme = Theme.of(context).colorScheme;
        final width = constraints.maxWidth;
        final height = compact
            ? 280.0
            : (constraints.maxHeight.isFinite
                  ? constraints.maxHeight
                  : _AuthSplitCard._stackHeight);
        final frameWidth = width * (compact ? 0.72 : 0.92);
        final frameHeight = compact ? 188.0 : height * 0.74;
        final imageWidth = (frameWidth * 1.06).clamp(0.0, width - 8);
        final frameBottom = (height - frameHeight) / 2;

        return SizedBox(
          height: height,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Center(
                child: SizedBox(
                  key: const Key('auth-dragon-frame'),
                  width: frameWidth,
                  height: frameHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: (width - imageWidth) / 2,
                width: imageWidth,
                bottom: frameBottom + 10,
                child: ExcludeSemantics(
                  child: IgnorePointer(
                    child: Image.asset(
                      AuthLoginScreen.dragonAsset,
                      key: const Key('auth-dragon'),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AuthFormCard extends StatelessWidget {
  const _AuthFormCard({
    required this.signUp,
    required this.overlapInset,
    required this.userNameController,
    required this.emailController,
    required this.passwordController,
    required this.submitting,
    required this.onSubmit,
    required this.onSwitch,
    this.error,
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
