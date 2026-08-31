import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/providers/refresh_provider.dart';

ProviderContainer testContainer() {
  final container = ProviderContainer.test(
    overrides: [refreshPingDelayProvider.overrideWithValue(Duration.zero)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('first read is fetch 1', () async {
    final container = testContainer();

    final ping = await container.read(refreshPingProvider.future);
    expect(ping.n, 1);
  });

  test('refresh returns a Future with the next fetch', () async {
    final container = testContainer();

    expect((await container.read(refreshPingProvider.future)).n, 1);

    final next = await container.refresh(refreshPingProvider.future);
    expect(next.n, 2);
  });

  test('invalidate rebuilds on the next read', () async {
    final container = testContainer();

    expect((await container.read(refreshPingProvider.future)).n, 1);

    container.invalidate(refreshPingProvider);

    expect((await container.read(refreshPingProvider.future)).n, 2);
  });

  test('three invalidates start one GET', () async {
    final container = testContainer();

    expect((await container.read(refreshPingProvider.future)).n, 1);

    container
      ..invalidate(refreshPingProvider)
      ..invalidate(refreshPingProvider)
      ..invalidate(refreshPingProvider);

    expect((await container.read(refreshPingProvider.future)).n, 2);
  });

  test('three refreshes start three GETs', () async {
    final container = testContainer();

    expect((await container.read(refreshPingProvider.future)).n, 1);

    final first = container.refresh(refreshPingProvider);
    final second = container.refresh(refreshPingProvider);
    final third = container.refresh(refreshPingProvider);
    expect(first.isLoading && second.isLoading && third.isLoading, isTrue);

    expect((await container.read(refreshPingProvider.future)).n, 4);
  });
}
