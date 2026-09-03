import 'package:flutter_riverpod/flutter_riverpod.dart';

/// In-memory authorized flag for the DELETE lab.
///
/// Starts false. `logIn` sets it true. There is no token, no backend check,
/// and no stored user. That is the point of the lab — see the README.
final apiLabSessionProvider = NotifierProvider<ApiLabSessionNotifier, bool>(
  ApiLabSessionNotifier.new,
);

class ApiLabSessionNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void logIn() {
    state = true;
  }
}
