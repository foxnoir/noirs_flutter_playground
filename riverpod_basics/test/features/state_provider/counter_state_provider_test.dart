import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/state_provider/presentation/providers/state_provider.dart';

void main() {
  test('counterStateProvider starts at 0 and updates through the notifier', () {
    // ProviderContainer is a Riverpod world without widgets.
    // The running app gets the same thing from ProviderScope in main.dart.
    final container = ProviderContainer();

    // addTearDown runs after this test — pass or fail.
    // Dispose drops listeners and cached state so the next test starts clean.
    // Do not put dispose() only at the bottom: a failing expect would skip it.
    addTearDown(container.dispose);

    // read() is a one-shot lookup. It does not subscribe.
    // watch() would listen for later changes; tests usually do not need that.
    expect(container.read(counterStateProvider), 0);

    // .notifier is the object that owns the mutable value.
    // Writing .state is the StateProvider API; a Notifier would expose methods.
    container.read(counterStateProvider.notifier).state++;
    // ++ runs once from 0, so the value must be 1. expect only checks that.
    expect(container.read(counterStateProvider), 1);

    container.read(counterStateProvider.notifier).state--;
    expect(container.read(counterStateProvider), 0);
  });
}
