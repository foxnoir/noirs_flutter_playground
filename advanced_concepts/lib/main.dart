import 'package:advanced_concepts/core/router/app_router.dart';
import 'package:advanced_concepts/core/theme/theme.dart';
import 'package:advanced_concepts/features/routing_lab/presentation/widgets/routing_lab_snack_bar_listener.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const ProviderScope(child: AdvancedConceptsApp()));
}

class AdvancedConceptsApp extends ConsumerWidget {
  const AdvancedConceptsApp({super.key});

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
        return RoutingLabSnackBarListener(
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
