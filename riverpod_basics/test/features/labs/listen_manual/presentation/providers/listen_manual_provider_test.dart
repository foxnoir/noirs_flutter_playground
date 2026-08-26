import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/listen_manual/presentation/providers/listen_manual_provider.dart';

void main() {
  test('storeError sets the fetch error', () {
    final container = ProviderContainer.test();
    addTearDown(container.dispose);

    container.read(listenManualErrorProvider.notifier).storeError();

    expect(container.read(listenManualErrorProvider), listenManualFetchError);
  });

  test('clearError clears the stored error', () {
    final container = ProviderContainer.test();
    addTearDown(container.dispose);

    container.read(listenManualErrorProvider.notifier).storeError();
    container.read(listenManualErrorProvider.notifier).clearError();

    expect(container.read(listenManualErrorProvider), isNull);
  });
}
