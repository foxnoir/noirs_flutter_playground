import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/providers/lifetimes_auto_dispose_provider.dart';

void main() {
  test('lifetimesAutoDisposeProvider disposes when unlistened', () async {
    final container = ProviderContainer.test();
    addTearDown(container.dispose);

    final sub = container.listen(lifetimesAutoDisposeProvider, (_, _) {});

    expect(container.read(lifetimesAutoDisposeProvider), '-');
    container.read(lifetimesAutoDisposeProvider.notifier).user = 'Ada';
    expect(container.read(lifetimesAutoDisposeProvider), 'Ada');

    sub.close();
    await container.pump();

    expect(container.exists(lifetimesAutoDisposeProvider), isFalse);

    final next = container.listen(lifetimesAutoDisposeProvider, (_, _) {});
    addTearDown(next.close);

    expect(container.read(lifetimesAutoDisposeProvider), '-');
  });
}
