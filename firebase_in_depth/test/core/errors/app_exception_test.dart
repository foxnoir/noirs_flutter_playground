import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_depth/core/errors/app_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fromFirebase maps not-found, invalid query, and everything else', () {
    expect(
      AppException.fromFirebase(
        FirebaseException(plugin: 'cloud_firestore', code: 'not-found'),
      ),
      const NotFoundException(),
    );
    expect(
      AppException.fromFirebase(
        FirebaseException(
          plugin: 'cloud_firestore',
          code: 'invalid-argument',
          message: 'two inequalities',
        ),
      ),
      const InvalidQueryException('two inequalities'),
    );
    expect(
      AppException.fromFirebase(
        FirebaseException(
          plugin: 'cloud_firestore',
          code: 'failed-precondition',
          message: 'The query requires an index.',
        ),
      ),
      const InvalidQueryException('The query requires an index.'),
    );
    expect(
      AppException.fromFirebase(
        FirebaseException(plugin: 'cloud_firestore', code: 'permission-denied'),
      ),
      const NetworkException(),
    );
  });
}
