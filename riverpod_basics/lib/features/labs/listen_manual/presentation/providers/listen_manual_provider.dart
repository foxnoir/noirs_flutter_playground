import 'package:flutter_riverpod/flutter_riverpod.dart';

const listenManualFetchError = 'fetchFailed';

final listenManualErrorProvider =
    NotifierProvider<ListenManualNotifier, String?>(ListenManualNotifier.new);

class ListenManualNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void storeError() => state = listenManualFetchError;

  void clearError() => state = null;
}
