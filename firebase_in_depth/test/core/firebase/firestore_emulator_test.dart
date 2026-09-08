import 'package:firebase_in_depth/core/firebase/firestore_emulator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDown(() => FirestoreEmulator.forceEnabled = false);

  test('emulator stays off unless dart-define is set', () {
    expect(FirestoreEmulator.enabled, isFalse);
    expect(FirestoreEmulator.connect, isFalse);
    expect(FirestoreEmulator.port, 8080);
    expect(FirestoreEmulator.host, '127.0.0.1');
  });

  test('forceEnabled connects without dart-define', () {
    FirestoreEmulator.forceEnabled = true;
    expect(FirestoreEmulator.connect, isTrue);
  });
}
