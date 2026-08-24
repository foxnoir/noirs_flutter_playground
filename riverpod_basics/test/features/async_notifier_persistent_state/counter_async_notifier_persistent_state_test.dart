import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/async_notifier_persistent_state/presentation/providers/async_notifier_persistent_state.dart';

void main() {
  test('persistentStateAsyncNotifierProvider keeps state on the container', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(persistentStateAsyncNotifierProvider).isLoading, isTrue);

    expect(await container.read(persistentStateAsyncNotifierProvider.future), 0);

    await container.read(persistentStateAsyncNotifierProvider.notifier).increment();
    expect(container.read(persistentStateAsyncNotifierProvider).value, 1);

    await container.read(persistentStateAsyncNotifierProvider.notifier).decrement();
    expect(container.read(persistentStateAsyncNotifierProvider).value, 0);

    final reset = container.read(persistentStateAsyncNotifierProvider.notifier).reset();
    expect(container.read(persistentStateAsyncNotifierProvider).isLoading, isTrue);
    await reset;
    expect(container.read(persistentStateAsyncNotifierProvider).value, 0);
  });
}
