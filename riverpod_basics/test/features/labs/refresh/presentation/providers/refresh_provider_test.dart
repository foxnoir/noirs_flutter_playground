import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/providers/refresh_provider.dart';

ProviderContainer testContainer() {
  final container = ProviderContainer.test(
    overrides: [refreshPingDelayProvider.overrideWith((_) => Duration.zero)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('first read returns a DateTime', () async {
    final container = testContainer();

    expect(await container.read(refreshPingProvider.future), isA<DateTime>());
  });

  test('refresh returns a Future that completes with a DateTime', () async {
    final container = testContainer();

    await container.read(refreshPingProvider.future);

    final next = container.refresh(refreshPingProvider.future);
    expect(await next, isA<DateTime>());
  });

  test('invalidate rebuilds on the next read', () async {
    final container = testContainer();

    await container.read(refreshPingProvider.future);
    container.invalidate(refreshPingProvider);

    expect(await container.read(refreshPingProvider.future), isA<DateTime>());
  });
}
