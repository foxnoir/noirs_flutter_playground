import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_in_depth/core/errors/app_exception.dart';
import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/auth/domain/entities/auth_session.dart';
import 'package:firebase_in_depth/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this._auth, required this._firestore});

  static const _users = 'users';

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  AuthSession? get currentSession =>
      _sessionFrom(_auth.currentUser, AuthRole.student);

  @override
  Stream<AuthSession?> watchSession() {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      return AuthSession(
        uid: user.uid,
        email: user.email ?? '',
        role: await _roleFor(user.uid),
      );
    });
  }

  @override
  Future<void> signIn({required String email, required String password}) {
    return _map(() async {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    });
  }

  @override
  Future<void> signUp({required String email, required String password}) {
    return _map(() async {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = credential.user;
      if (user == null) return;
      await _firestore.collection(_users).doc(user.uid).set({
        'email': user.email ?? email.trim(),
        'role': AuthRole.student.name,
      });
    });
  }

  @override
  Future<void> signOut() {
    return _map(_auth.signOut);
  }

  Future<AuthRole> _roleFor(String uid) async {
    try {
      final snap = await _firestore.collection(_users).doc(uid).get();
      final role = snap.data()?['role'] as String?;
      return role == AuthRole.tutor.name ? AuthRole.tutor : AuthRole.student;
    } on FirebaseException {
      return AuthRole.student;
    }
  }

  Future<void> _map(Future<void> Function() run) async {
    try {
      await run();
    } on FirebaseAuthException catch (error) {
      throw AppFailure.fromException(AppException.fromFirebase(error));
    } on AppException catch (error) {
      throw AppFailure.fromException(error);
    }
  }

  static AuthSession? _sessionFrom(User? user, AuthRole role) {
    if (user == null) return null;
    return AuthSession(uid: user.uid, email: user.email ?? '', role: role);
  }
}
