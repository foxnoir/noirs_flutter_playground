import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthNavSnackKind { goNamed, goNamedThenRedirect, redirect }

class AuthNavSnack {
  AuthNavSnack(this.kind);

  final AuthNavSnackKind kind;
}

final authNavSnackProvider =
    NotifierProvider<AuthNavSnackNotifier, AuthNavSnack?>(
      AuthNavSnackNotifier.new,
    );

class AuthNavSnackNotifier extends Notifier<AuthNavSnack?> {
  var _goNamedPending = false;

  @override
  AuthNavSnack? build() => null;

  void markGoNamed() => _goNamedPending = true;

  void emitRedirect() {
    state = AuthNavSnack(
      _goNamedPending
          ? AuthNavSnackKind.goNamedThenRedirect
          : AuthNavSnackKind.redirect,
    );
    _goNamedPending = false;
  }

  void flushIfGoNamedOnly() {
    if (!_goNamedPending) return;
    _goNamedPending = false;
    state = AuthNavSnack(AuthNavSnackKind.goNamed);
  }
}
