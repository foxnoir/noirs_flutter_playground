import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/providers/lifetimes_keep_alive_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class KeepAliveSnackBarListener extends ConsumerWidget {
  const KeepAliveSnackBarListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(keepAliveNoticeProvider, (previous, next) {
      if (next == null) return;
      final l10n = AppLocalizations.of(context);
      final message = switch (next.lifecycle) {
        KeepAliveLifecycle.resume => l10n.keepAliveOnResume,
        KeepAliveLifecycle.dispose => l10n.keepAliveOnDispose,
      };
      // Resume fires while the Provider Lifetimes route is still pushing. Wait until
      // that frame is committed so the SnackBar lands on the new screen.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
              duration: keepAliveSnackBarDuration,
            ),
          );
      });
    });

    return child;
  }
}
