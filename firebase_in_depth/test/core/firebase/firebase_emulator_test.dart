import 'package:firebase_in_depth/core/firebase/firebase_emulator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('emulator stays off unless dart-define is set', () {
    expect(FirebaseEmulator.enabled, isFalse);
    expect(FirebaseEmulator.firestorePort, 8080);
    expect(FirebaseEmulator.authPort, 9099);
    expect(FirebaseEmulator.host, '127.0.0.1');
  });
}
