import 'package:firebase_in_depth/main.dart';

/// Run/Debug **Firebase in Depth (emulator)**. Always local Firestore.
/// If the emulator is down, reads fail — no silent fallback to the cloud.
Future<void> main() {
  return bootstrap(useEmulator: true);
}
