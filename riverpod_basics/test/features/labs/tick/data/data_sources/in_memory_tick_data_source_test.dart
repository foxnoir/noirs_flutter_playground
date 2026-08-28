import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/errors/app_exception.dart';
import 'package:riverpod_basics/features/labs/tick/data/data_sources/in_memory_tick_data_source.dart';

void main() {
  test('emits incrementing ticks', () async {
    final source = InMemoryTickDataSource(
      interval: const Duration(milliseconds: 1),
    );

    final models = await source.watchTicks().take(2).toList();

    expect(models.map((model) => model.n), [1, 2]);
  });

  test('failCall throws NetworkException on the next tick', () async {
    final source = InMemoryTickDataSource(
      interval: const Duration(milliseconds: 1),
    );
    final events = <Object>[];
    final sub = source.watchTicks().listen(events.add, onError: events.add);
    addTearDown(sub.cancel);

    await Future<void>.delayed(const Duration(milliseconds: 5));
    expect(events.whereType<NetworkException>(), isEmpty);
    expect(events.length, greaterThanOrEqualTo(1));

    source.failCall();
    await Future<void>.delayed(const Duration(milliseconds: 5));

    expect(events.whereType<NetworkException>(), isNotEmpty);
  });

  test('interval must be greater than zero', () {
    expect(
      () => InMemoryTickDataSource(interval: Duration.zero),
      throwsArgumentError,
    );
  });
}
