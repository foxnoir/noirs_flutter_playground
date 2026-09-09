import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_in_depth/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:firebase_in_depth/features/auth/domain/entities/auth_session.dart';
import 'package:firebase_in_depth/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

final authProvider = NotifierProvider<AuthNotifier, AuthSession?>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthSession?> {
  @override
  AuthSession? build() {
    final repository = ref.watch(authRepositoryProvider);
    final subscription = repository.watchSession().listen((session) {
      state = session;
    });
    ref.onDispose(subscription.cancel);
    return repository.currentSession;
  }

  Future<void> signIn({required String email, required String password}) async {
    await ref
        .read(authRepositoryProvider)
        .signIn(email: email, password: password);
    state = ref.read(authRepositoryProvider).currentSession;
  }

  Future<void> signUp({required String email, required String password}) async {
    await ref
        .read(authRepositoryProvider)
        .signUp(email: email, password: password);
    state = ref.read(authRepositoryProvider).currentSession;
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = null;
  }
}
