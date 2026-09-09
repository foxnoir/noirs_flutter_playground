import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthFormState {
  const AuthFormState({this.submitting = false, this.failure});

  final bool submitting;
  final AppFailure? failure;
}

final authFormProvider =
    NotifierProvider.autoDispose<AuthFormNotifier, AuthFormState>(
      AuthFormNotifier.new,
    );

class AuthFormNotifier extends Notifier<AuthFormState> {
  @override
  AuthFormState build() => const AuthFormState();

  void clearFailure() {
    if (state.failure == null) return;
    state = AuthFormState(submitting: state.submitting);
  }

  Future<void> submit({
    required bool signUp,
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty || state.submitting) return;

    state = const AuthFormState(submitting: true);
    try {
      final auth = ref.read(authProvider.notifier);
      if (signUp) {
        await auth.signUp(email: email, password: password);
      } else {
        await auth.signIn(email: email, password: password);
      }
      if (!ref.mounted) return;
      state = const AuthFormState();
    } on AppFailure catch (failure) {
      if (!ref.mounted) return;
      state = AuthFormState(failure: failure);
    } catch (_) {
      if (!ref.mounted) return;
      state = const AuthFormState(failure: UnknownFailure());
    }
  }
}
