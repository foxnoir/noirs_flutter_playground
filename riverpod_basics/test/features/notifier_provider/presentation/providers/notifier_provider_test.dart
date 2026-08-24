import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/notifier_provider/presentation/providers/notifier_provider.dart';

void main() {
  test('counterNotifierProvider starts at 0 and updates through methods', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(counterNotifierProvider), 0);

    container.read(counterNotifierProvider.notifier).increment();
    // increment runs once from 0, so the value must be 1. expect only checks that.
    expect(container.read(counterNotifierProvider), 1);

    container.read(counterNotifierProvider.notifier).decrement();
    expect(container.read(counterNotifierProvider), 0);
  });
}
