import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basic_starter/core/router/app_router.dart';
import 'package:riverpod_basic_starter/core/theme/theme.dart';
import 'package:riverpod_basic_starter/l10n/app_localizations.dart';

void main() {
  runApp(const ProviderScope(child: RiverpodBasicStarterApp()));
}

class RiverpodBasicStarterApp extends ConsumerWidget {
  const RiverpodBasicStarterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).title,
      theme: getLightTheme(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
