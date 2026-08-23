import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/router/app_router.dart';
import 'package:riverpod_basics/core/theme/theme.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

// hier könnte ihre Werbung stehen

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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
