import 'package:firebase_in_depth/core/router/app_router_names.dart';
import 'package:firebase_in_depth/core/theme/app_color.dart';
import 'package:firebase_in_depth/features/auth/domain/entities/auth_session.dart';
import 'package:firebase_in_depth/features/auth/presentation/providers/auth_provider.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:firebase_in_depth/shared_widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthHeaderDesktop extends ConsumerWidget {
  const AuthHeaderDesktop({this.currentRoute, super.key});

  final String? currentRoute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authProvider);
    if (session != null) {
      return _AccountMenu(session: session);
    }
    if (currentRoute == AppRouteNames.login) {
      return const SizedBox.shrink();
    }
    return const _AuthLinks();
  }
}

class _AuthLinks extends StatelessWidget {
  const _AuthLinks();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return GradientButton(
      key: const Key('header-auth'),
      label: l10n.signInSignUp,
      compact: true,
      startColor: AppColor.secondarySoft,
      endColor: AppColor.secondary,
      foregroundColor: AppColor.teal,
      onPressed: () => _open(context),
    );
  }

  void _open(BuildContext context) {
    final router = GoRouter.maybeOf(context);
    if (router == null) return;
    context.pushNamed(AppRouteNames.login);
  }
}

class _AccountMenu extends ConsumerWidget {
  const _AccountMenu({required this.session});

  final AuthSession session;

  static String _roleIcon(AuthRole role) => switch (role) {
    AuthRole.tutor => 'assets/icons/categories/advanced.png',
    AuthRole.student => 'assets/icons/categories/beginner.png',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final iconAsset = _roleIcon(session.role);

    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          key: const Key('header-account'),
          tooltip: session.email,
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: ClipOval(
            child: Image.asset(
              iconAsset,
              width: 32,
              height: 32,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      menuChildren: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(session.email, style: textTheme.bodySmall),
              const SizedBox(height: 4),
              Text(
                session.role == AuthRole.tutor
                    ? l10n.authRoleTutor
                    : l10n.authRoleStudent,
                style: textTheme.labelMedium,
              ),
            ],
          ),
        ),
        const Divider(),
        MenuItemButton(
          onPressed: () => ref.read(authProvider.notifier).signOut(),
          child: Text(l10n.signOut),
        ),
      ],
    );
  }
}
