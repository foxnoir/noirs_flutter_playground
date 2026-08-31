import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/router/app_router.dart';
import 'package:riverpod_basics/core/theme/theme.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/widgets/auth_nav_snack_bar_listener.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/widgets/keep_alive_snack_bar_listener.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

void main() {
  runApp(const ProviderScope(child: RiverpodBasicsApp()));
}

class RiverpodBasicsApp extends ConsumerWidget {
  const RiverpodBasicsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: getLightTheme(),
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
      builder: (context, child) {
        return KeepAliveSnackBarListener(
          child: AuthNavSnackBarListener(
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
