import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shared API host. Not a secret — override at build time, do not scatter URLs.
///
/// Default is the Firebase emulator. Deployed Functions:
/// `fvm flutter run --dart-define=API_BASE_URL=https://.../api/`
abstract final class ApiConfig {
  static const emulatorBaseUrl =
      'http://127.0.0.1:5001/noirs-firebase-lab/europe-west1/api/';

  /// Closed port — a real TCP failure, not an HTTP status.
  static const offlineUrl = 'http://127.0.0.1:1/offline';

  static const _fromEnvironment = String.fromEnvironment('API_BASE_URL');

  static Uri get baseUrl {
    var raw = _fromEnvironment.isEmpty ? emulatorBaseUrl : _fromEnvironment;
    if (!raw.endsWith('/')) {
      raw = '$raw/';
    }
    return Uri.parse(raw);
  }

  static Uri get offlineUri => Uri.parse(offlineUrl);
}

final apiBaseUrlProvider = Provider<Uri>((ref) => ApiConfig.baseUrl);
