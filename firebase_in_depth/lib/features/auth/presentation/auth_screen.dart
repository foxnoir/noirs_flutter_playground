import 'package:firebase_in_depth/core/router/app_router_names.dart';
import 'package:firebase_in_depth/features/auth/presentation/providers/auth_provider.dart';
import 'package:firebase_in_depth/features/auth/presentation/widgets/auth_split_card.dart';
import 'package:firebase_in_depth/shared_widgets/desktop_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (previous, next) {
      if (previous != null || next == null) return;
      if (context.canPop()) {
        context.pop();
      } else {
        context.goNamed(AppRouteNames.landing);
      }
    });

    return DesktopScaffold(
      currentRoute: AppRouteNames.login,
      body: Align(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 920),
            child: const AuthSplitCard(),
          ),
        ),
      ),
    );
  }
}
