import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/providers/lifetimes_persistent_provider.dart';

void main() {
  test('lifetimesPersistentProvider keeps state when unlistened', () async {
    final container = ProviderContainer.test();
    addTearDown(container.dispose);

    final sub = container.listen(lifetimesPersistentProvider, (_, _) {});

    expect(container.read(lifetimesPersistentProvider), '-');
    container.read(lifetimesPersistentProvider.notifier).user = 'Ada';
    expect(container.read(lifetimesPersistentProvider), 'Ada');

    sub.close();
    await container.pump();

    expect(container.exists(lifetimesPersistentProvider), isTrue);
    expect(container.read(lifetimesPersistentProvider), 'Ada');
  });
}
