import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/tick/data/repositories/in_memory_tick_repository.dart';
import 'package:riverpod_basics/features/labs/tick/domain/entities/tick.dart';

/// Handwritten StreamProvider so the type is visible.
/// autoDispose cancels the fake /tick stream when nobody watches.
/// `retry: null` matches codegen labs. Riverpod 3 otherwise retries a
/// failed stream (200ms+), which would hide **Fail call**.
final tickProvider = StreamProvider.autoDispose<Tick>((ref) {
  return ref.watch(tickRepositoryProvider).watchTicks();
}, retry: (_, _) => null);

/// Whether the screen is subscribed to [tickProvider].
/// Stop drops the watch; autoDispose cancels the fake /tick timer.
/// Start watches again — a new stream at tick 1.
final tickRunningProvider = NotifierProvider<TickRunningNotifier, bool>(
  TickRunningNotifier.new,
);

class TickRunningNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void start() => state = true;

  void stop() => state = false;
}

/// [tickProvider] has no methods. The screen calls [TickFailCallNotifier.failCall];
/// this notifier talks to the repository.
final tickFailCallProvider = NotifierProvider<TickFailCallNotifier, bool>(
  TickFailCallNotifier.new,
);

class TickFailCallNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void failCall() => ref.read(tickRepositoryProvider).failCall();
}
