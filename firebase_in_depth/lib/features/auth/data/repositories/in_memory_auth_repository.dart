import 'dart:async';

import 'package:firebase_in_depth/features/auth/domain/entities/auth_session.dart';
import 'package:firebase_in_depth/features/auth/domain/repositories/auth_repository.dart';

/// Used in tests and when the Auth emulator is off (no live Auth yet).
class InMemoryAuthRepository implements AuthRepository {
  InMemoryAuthRepository();

  AuthSession? _session;
  final _controller = StreamController<AuthSession?>.broadcast();

  void dispose() => _controller.close();

  @override
  AuthSession? get currentSession => _session;

  @override
  Stream<AuthSession?> watchSession() async* {
    yield _session;
    yield* _controller.stream;
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty || password.isEmpty) return;
    _session = AuthSession(
      uid: 'local',
      email: trimmed,
      role: trimmed.toLowerCase() == 'tutor@lab.dev'
          ? AuthRole.tutor
          : AuthRole.student,
    );
    _controller.add(_session);
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty || password.isEmpty) return;
    _session = AuthSession(uid: 'local', email: trimmed);
    _controller.add(_session);
  }

  @override
  Future<void> signOut() async {
    _session = null;
    _controller.add(null);
  }
}
