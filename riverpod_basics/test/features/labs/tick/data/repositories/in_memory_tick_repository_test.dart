import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/errors/app_exception.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/tick/data/models/tick_model.dart';
import 'package:riverpod_basics/features/labs/tick/data/repositories/in_memory_tick_repository.dart';

import '../../fake_tick_data_source.dart';

void main() {
  final emittedAt = DateTime(2026, 1, 1, 12);

  test('maps models to Tick entities', () async {
    final repository = InMemoryTickRepository(
      FakeTickDataSource(models: [TickModel(n: 1, emittedAt: emittedAt)]),
    );

    final ticks = await repository.watchTicks().toList();

    expect(ticks, hasLength(1));
    expect(ticks.single.n, 1);
    expect(ticks.single.emittedAt, emittedAt);
  });

  test('maps NetworkException to NetworkFailure', () async {
    final repository = InMemoryTickRepository(
      FakeTickDataSource(error: const NetworkException()),
    );

    await expectLater(
      repository.watchTicks().toList(),
      throwsA(isA<NetworkFailure>()),
    );
  });
}
