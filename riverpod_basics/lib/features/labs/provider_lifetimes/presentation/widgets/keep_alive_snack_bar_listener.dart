import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/providers/add_user_keep_alive_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class AddUserKeepAliveSnackBarListener extends ConsumerWidget {
  const AddUserKeepAliveSnackBarListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(addUserKeepAliveNoticeProvider, (previous, next) {
      if (next == null) return;
      final l10n = AppLocalizations.of(context);
      final message = switch (next.lifecycle) {
        AddUserKeepAliveLifecycle.resume => l10n.keepAliveOnResume,
        AddUserKeepAliveLifecycle.dispose => l10n.keepAliveOnDispose,
      };
      // Resume fires while the Add User route is still pushing. Wait until
      // that frame is committed so the SnackBar lands on the new screen.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
              duration: addUserKeepAliveSnackBarDuration,
            ),
          );
      });
    });

    return child;
  }
}
