import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/auth/domain/entities/auth_session.dart';
import 'package:firebase_in_depth/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_in_depth/features/auth/presentation/providers/auth_form_provider.dart';
import 'package:firebase_in_depth/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fake_auth_repository.dart';

class _FailingAuthRepository implements AuthRepository {
  @override
  AuthSession? get currentSession => null;

  @override
  Stream<AuthSession?> watchSession() => const Stream.empty();

  @override
  Future<void> signIn({required String email, required String password}) {
    return Future.error(const AuthFailure());
  }

  @override
  Future<void> signUp({required String email, required String password}) {
    return Future.error(const AuthFailure());
  }

  @override
  Future<void> signOut() async {}
}

void main() {
  test('submit sign-in stores the session', () async {
    final container = ProviderContainer.test(
      overrides: [
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      ],
    );
    addTearDown(container.dispose);

    await container
        .read(authFormProvider.notifier)
        .submit(signUp: false, email: 'noir@lab.dev', password: '');

    expect(container.read(authProvider)?.email, 'noir@lab.dev');
    expect(container.read(authFormProvider).submitting, isFalse);
    expect(container.read(authFormProvider).failure, isNull);
  });

  test('submit keeps AuthFailure when sign-in fails', () async {
    final container = ProviderContainer.test(
      overrides: [
        authRepositoryProvider.overrideWithValue(_FailingAuthRepository()),
      ],
    );
    addTearDown(container.dispose);

    await container
        .read(authFormProvider.notifier)
        .submit(signUp: false, email: 'noir@lab.dev', password: 'nope');

    expect(container.read(authProvider), isNull);
    expect(container.read(authFormProvider).submitting, isFalse);
    expect(container.read(authFormProvider).failure, const AuthFailure());
  });

  test('empty credentials do not submit', () async {
    final container = ProviderContainer.test(
      overrides: [
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      ],
    );
    addTearDown(container.dispose);

    await container
        .read(authFormProvider.notifier)
        .submit(signUp: false, email: '', password: '');

    expect(container.read(authProvider), isNull);
    expect(container.read(authFormProvider).submitting, isFalse);
  });
}
