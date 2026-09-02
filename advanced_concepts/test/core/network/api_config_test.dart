import 'package:advanced_concepts/core/network/api_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'baseUrl defaults to the Firebase emulator and keeps a trailing slash',
    () {
      expect(
        ApiConfig.baseUrl.toString(),
        'http://127.0.0.1:5001/noirs-firebase-lab/europe-west1/api/',
      );
      expect(ApiConfig.offlineUri.port, 1);
    },
  );
}
