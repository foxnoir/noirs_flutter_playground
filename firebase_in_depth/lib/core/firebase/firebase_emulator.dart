import 'package:flutter/foundation.dart';

/// Local Firebase emulators. Opt in with
/// `--dart-define=USE_FIREBASE_EMULATOR=true`.
/// Functions use this same flag when that SDK lands.
abstract final class FirebaseEmulator {
  static const enabled = bool.fromEnvironment('USE_FIREBASE_EMULATOR');
  static const firestorePort = 8080;
  static const authPort = 9099;

  /// Web talks to `localhost`; iOS Simulator needs loopback.
  static String get host => kIsWeb ? 'localhost' : '127.0.0.1';
}
