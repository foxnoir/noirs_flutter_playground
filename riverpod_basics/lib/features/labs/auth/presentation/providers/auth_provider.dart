import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Session flag. Sign in / sign up / sign out are methods — that is a
/// Notifier, not a read-only Provider. The GoRouter mailbox only reads this.
/// This lab does not check username or password.
final authProvider = NotifierProvider<AuthNotifier, bool>(AuthNotifier.new);

class AuthNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void signIn() => state = true;

  void signUp() => state = true;

  void signOut() => state = false;
}
