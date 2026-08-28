import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/tick/data/data_sources/in_memory_tick_data_source.dart';
import 'package:riverpod_basics/features/labs/tick/data/repositories/in_memory_tick_repository.dart';
import 'package:riverpod_basics/features/labs/tick/domain/entities/tick.dart';
import 'package:riverpod_basics/features/labs/tick/domain/repositories/tick_repository.dart';
import 'package:riverpod_basics/features/labs/tick/presentation/providers/tick_provider.dart';

import '../../fake_tick_repository.dart';

void main() {
  final emittedAt = DateTime(2026, 1, 1, 12);
  final tick = Tick(n: 1, emittedAt: emittedAt);

  ProviderContainer containerWith({required TickRepository repository}) {
    final container = ProviderContainer.test(
      overrides: [tickRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('loads the first tick', () async {
    final container = containerWith(
      repository: FakeTickRepository(ticks: [tick]),
    )..listen(tickProvider, (_, _) {});

    final loaded = await container.read(tickProvider.future);

    expect(loaded.n, 1);
    expect(loaded.emittedAt, emittedAt);
  });

  test('keeps the latest tick', () async {
    final controller = StreamController<Tick>();
    addTearDown(controller.close);
    final container = containerWith(
      repository: FakeTickRepository(stream: controller.stream),
    );
    final sub = container.listen(tickProvider, (_, _) {});

    await container.pump();
    expect(sub.read().isLoading, isTrue);

    controller.add(tick);
    await container.pump();
    expect(sub.read().value?.n, 1);

    controller.add(Tick(n: 2, emittedAt: emittedAt));
    await container.pump();
    expect(sub.read().value?.n, 2);
  });

  test('a repository failure is AsyncError with NetworkFailure', () async {
    final container = containerWith(
      repository: FakeTickRepository(error: const NetworkFailure()),
    );
    final sub = container.listen(tickProvider, (_, _) {});

    await container.pump();

    expect(sub.read().error, isA<NetworkFailure>());
  });

  test('failCall errors the stream without invalidate', () async {
    final container = ProviderContainer.test(
      overrides: [
        tickIntervalProvider.overrideWithValue(
          const Duration(milliseconds: 10),
        ),
      ],
    );
    addTearDown(container.dispose);
    final sub = container.listen(tickProvider, (_, _) {});

    await Future<void>.delayed(const Duration(milliseconds: 25));
    expect(sub.read().value?.n, greaterThanOrEqualTo(1));

    container.read(tickFailCallProvider.notifier).failCall();
    await Future<void>.delayed(const Duration(milliseconds: 25));

    expect(sub.read().error, isA<NetworkFailure>());
  });

  test('running defaults to true; stop and start toggle it', () {
    final container = ProviderContainer.test();
    addTearDown(container.dispose);

    expect(container.read(tickRunningProvider), isTrue);

    container.read(tickRunningProvider.notifier).stop();
    expect(container.read(tickRunningProvider), isFalse);

    container.read(tickRunningProvider.notifier).start();
    expect(container.read(tickRunningProvider), isTrue);
  });

  test('invalidate starts a new stream', () async {
    final repository = FakeTickRepository(ticks: [tick]);
    final container = containerWith(repository: repository)
      ..listen(tickProvider, (_, _) {});

    await container.read(tickProvider.future);
    expect(repository.watchCalls, 1);

    container.invalidate(tickProvider);
    await container.read(tickProvider.future);

    expect(repository.watchCalls, 2);
  });
}
