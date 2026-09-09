import 'package:firebase_in_depth/core/router/app_router_names.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:firebase_in_depth/shared_widgets/desktop_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DesktopScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.missing, style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                final router = GoRouter.maybeOf(context);
                if (router == null) return;
                context.goNamed(AppRouteNames.landing);
              },
              child: Text(l10n.back),
            ),
          ],
        ),
      ),
    );
  }
}
