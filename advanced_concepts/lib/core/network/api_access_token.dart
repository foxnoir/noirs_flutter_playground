import 'package:advanced_concepts/core/network/http/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Lab token the emulator DELETE accepts. Not JWT, not Firebase Auth.
abstract final class ApiLabAccessToken {
  static const value = 'lab';
  static const header = 'Bearer lab';
}

/// Mutable holder so [ApiClient] / Dio read the current token without
/// recreating the client on login.
class ApiAccessToken {
  String? value;
}

final apiAccessTokenProvider = Provider<ApiAccessToken>((ref) {
  return ApiAccessToken();
});
