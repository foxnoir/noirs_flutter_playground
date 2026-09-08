import 'package:firebase_in_depth/core/firebase/emulator_connect.dart';
import 'package:flutter/foundation.dart';

/// Local Firestore emulator.
///
/// CLI: `--dart-define=USE_FIRESTORE_EMULATOR=true`.
/// IDE: launch config **Firebase in Depth (emulator)** sets [kConnectFirestoreEmulator].
abstract final class FirestoreEmulator {
  static const enabled = bool.fromEnvironment('USE_FIRESTORE_EMULATOR');

  static bool forceEnabled = false;

  static bool get connect =>
      forceEnabled || enabled || kConnectFirestoreEmulator;
  static const port = 8080;

  /// Web talks to `localhost`; iOS Simulator needs loopback.
  static String get host => kIsWeb ? 'localhost' : '127.0.0.1';
}
