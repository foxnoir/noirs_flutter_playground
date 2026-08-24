import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/async_notifier_non_persistent_state/presentation/providers/async_notifier_non_persistent_state.dart';

void main() {
  test('nonPersistentStateAsyncNotifierProvider disposes when unlistened', () async {
    final container = ProviderContainer.test();
    addTearDown(container.dispose);

    final sub = container.listen(
      nonPersistentStateAsyncNotifierProvider,
      (_, _) {},
    );

    expect(container.read(nonPersistentStateAsyncNotifierProvider).isLoading, isTrue);
    expect(await container.read(nonPersistentStateAsyncNotifierProvider.future), 0);

    await container.read(nonPersistentStateAsyncNotifierProvider.notifier).increment();
    expect(container.read(nonPersistentStateAsyncNotifierProvider).value, 1);

    await container.read(nonPersistentStateAsyncNotifierProvider.notifier).decrement();
    expect(container.read(nonPersistentStateAsyncNotifierProvider).value, 0);

    await container.read(nonPersistentStateAsyncNotifierProvider.notifier).increment();
    expect(container.read(nonPersistentStateAsyncNotifierProvider).value, 1);

    final reset = container.read(nonPersistentStateAsyncNotifierProvider.notifier).reset();
    expect(container.read(nonPersistentStateAsyncNotifierProvider).isLoading, isTrue);
    await reset;
    expect(container.read(nonPersistentStateAsyncNotifierProvider).value, 0);

    // Same as Back: last watcher gone. pump lets autoDispose run.
    sub.close();
    await container.pump();

    expect(container.exists(nonPersistentStateAsyncNotifierProvider), isFalse);

    final next = container.listen(
      nonPersistentStateAsyncNotifierProvider,
      (_, _) {},
    );
    addTearDown(next.close);

    expect(container.read(nonPersistentStateAsyncNotifierProvider).isLoading, isTrue);
    expect(await container.read(nonPersistentStateAsyncNotifierProvider.future), 0);
  });
}
