import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_depth/core/firebase/firestore_emulator.dart';
import 'package:firebase_in_depth/core/router/app_router.dart';
import 'package:firebase_in_depth/core/theme/theme.dart';
import 'package:firebase_in_depth/firebase_options.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() {
  return bootstrap(useEmulator: FirestoreEmulator.connect);
}

/// Chrome / iOS: [useEmulator] is false unless `--dart-define` is set.
/// Emulator launch: [main_emulator.dart] calls this with `true`.
Future<void> bootstrap({required bool useEmulator}) async {
  FirestoreEmulator.forceEnabled = useEmulator;
  WidgetsFlutterBinding.ensureInitialized();
  // Tests run on the VM (not web / iOS) and skip init.
  if (kIsWeb || defaultTargetPlatform == TargetPlatform.iOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (useEmulator) {
      if (kIsWeb) {
        FirebaseFirestore.instance.settings = const Settings(
          persistenceEnabled: false,
        );
      }
      FirebaseFirestore.instance.useFirestoreEmulator(
        FirestoreEmulator.host,
        FirestoreEmulator.port,
      );
    }
  }
  runApp(const ProviderScope(child: FirebaseInDepthApp()));
}

class FirebaseInDepthApp extends ConsumerWidget {
  const FirebaseInDepthApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).title,
      theme: getLightTheme(),
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
