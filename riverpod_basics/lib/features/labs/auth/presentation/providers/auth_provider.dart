import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Session flag. Login / logout are methods — that is a Notifier, not a
/// read-only Provider. The GoRouter mailbox only reads this.
final authProvider = NotifierProvider<AuthNotifier, bool>(AuthNotifier.new);

class AuthNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void login() => state = true;

  void logout() => state = false;
}
