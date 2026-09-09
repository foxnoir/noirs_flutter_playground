import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/core/errors/app_failure_message.dart';
import 'package:firebase_in_depth/core/router/app_router_names.dart';
import 'package:firebase_in_depth/core/theme/app_breakpoint.dart';
import 'package:firebase_in_depth/features/auth/presentation/providers/auth_form_provider.dart';
import 'package:firebase_in_depth/features/auth/presentation/widgets/auth_panel.dart';
import 'package:firebase_in_depth/features/auth/presentation/widgets/auth_form_card.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthSplitCard extends ConsumerStatefulWidget {
  const AuthSplitCard({super.key});

  static const swapDuration = Duration(milliseconds: 520);

  @override
  ConsumerState<AuthSplitCard> createState() => _AuthSplitCardState();
}

class _AuthSplitCardState extends ConsumerState<AuthSplitCard> {
  late final TextEditingController _userNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  var _signUp = false;
  var _modeFromRoute = false;

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

  void _toggleMode() {
    setState(() => _signUp = !_signUp);
    ref.read(authFormProvider.notifier).clearFailure();
  }

  Future<void> _submit() {
    return ref
        .read(authFormProvider.notifier)
        .submit(
          signUp: _signUp,
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  String? _errorText(AuthFormState form, AppLocalizations l10n) {
    final failure = form.failure;
    if (failure == null) return null;
    if (_signUp && (failure is AuthFailure || failure is UnknownFailure)) {
      return l10n.authSignUpFailed;
    }
    if (!_signUp && failure is UnknownFailure) {
      return l10n.authSignInFailed;
    }
    return failure.message(l10n);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final form = ref.watch(authFormProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < AppBreakpoint.mediumMin;
        final width = constraints.maxWidth;
        final panelWidth = compact ? width : width * 0.61;
        final formWidth = compact ? width : width * 0.47;
        final overlap = compact ? 0.0 : panelWidth + formWidth - width;
        final card = AuthFormCard(
          signUp: _signUp,
          overlapInset: overlap,
          userNameController: _userNameController,
          emailController: _emailController,
          passwordController: _passwordController,
          error: _errorText(form, l10n),
          submitting: form.submitting,
          onSubmit: _submit,
          onSwitch: form.submitting ? null : _toggleMode,
        );
        final panel = AuthPanel(compact: compact);

        if (compact) {
          return Column(
            children: [
              if (!_signUp) ...[panel, const SizedBox(height: 16)],
              card,
              if (_signUp) ...[const SizedBox(height: 16), panel],
            ],
          );
        }

        final panelLeft = _signUp ? width - panelWidth : 0.0;
        final formLeft = _signUp ? 0.0 : panelWidth - overlap;

        return SizedBox(
          height: AuthPanel.stackHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedPositioned(
                duration: AuthSplitCard.swapDuration,
                curve: Curves.easeInOutCubic,
                left: formLeft,
                top: 0,
                bottom: 0,
                width: formWidth,
                child: Center(child: card),
              ),
              AnimatedPositioned(
                duration: AuthSplitCard.swapDuration,
                curve: Curves.easeInOutCubic,
                left: panelLeft,
                top: 0,
                width: panelWidth,
                height: AuthPanel.stackHeight,
                child: panel,
              ),
            ],
          ),
        );
      },
    );
  }
}
