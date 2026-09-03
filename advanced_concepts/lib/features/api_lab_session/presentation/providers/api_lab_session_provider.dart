import 'package:advanced_concepts/core/network/api_access_token.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// AppBar lock. The emulator decides DELETE: token on the request, or 401.
final apiLabSessionProvider = NotifierProvider<ApiLabSessionNotifier, bool>(
  ApiLabSessionNotifier.new,
);

class ApiLabSessionNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void logIn() {
    ref.read(apiAccessTokenProvider).value = ApiLabAccessToken.value;
    state = true;
  }
}
