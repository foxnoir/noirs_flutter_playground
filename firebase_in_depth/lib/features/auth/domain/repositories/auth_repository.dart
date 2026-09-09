import 'package:firebase_in_depth/features/auth/domain/entities/auth_session.dart';

abstract interface class AuthRepository {
  AuthSession? get currentSession;

  Stream<AuthSession?> watchSession();

  Future<void> signIn({required String email, required String password});

  Future<void> signUp({required String email, required String password});

  Future<void> signOut();
}
