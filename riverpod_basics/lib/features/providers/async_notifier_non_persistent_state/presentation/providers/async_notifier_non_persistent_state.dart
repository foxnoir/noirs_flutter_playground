import 'package:flutter_riverpod/flutter_riverpod.dart';

// Same class as Persistent State. Non-persistence is only .autoDispose —
// in-memory lifetime, not disk. Screen watch keeps this alive. Back pops
// the widget → last watcher gone → Riverpod disposes. Next visit: new
// notifier, build() runs, loading, count is 0.
final nonPersistentStateAsyncNotifierProvider =
    AsyncNotifierProvider.autoDispose<NonPersistentStateAsyncNotifier, int>(
      NonPersistentStateAsyncNotifier.new,
    );

// AsyncNotifier is a Notifier whose state is AsyncValue<T>: loading, error, data.
// Use it when the first value (or an update) comes from a Future.
// The <int> is the payload: state is AsyncValue<int>, future is Future<int>.
class NonPersistentStateAsyncNotifier extends AsyncNotifier<int> {
  // First read. Riverpod sets state to AsyncLoading. The value you return
  // becomes state: return 0 → AsyncData(0). Throw → AsyncError.
  @override
  Future<int> build() async {
    // Stands in for a repository/API Future so the UI can show loading.
    // This Future.delayed is Dart's timer, not the `future` getter below.
    final result = await Future.delayed(const Duration(seconds: 3), () => 0);
    return result;
  }

  // `future` unwraps this object's state (the int from build, or a later
  // AsyncData). Assigning `state` notifies every `ref.watch`.
  Future<void> increment() async {
    final current = await future;
    state = AsyncData(current + 1);
  }

  Future<void> decrement() async {
    final current = await future;
    state = AsyncData(current - 1);
  }

  // Reload on this page. Does not dispose the provider — Back does that.
  // Assigning AsyncLoading notifies watchers now. invalidate() does not:
  // when() keeps showing data on refresh (skipLoadingOnRefresh).
  Future<void> reset() async {
    state = const AsyncLoading();
    // Same as Persistent State: guard turns the Future into AsyncData / AsyncError.
    state = await AsyncValue.guard(() async {
      return Future.delayed(const Duration(seconds: 3), () => 0);
    });
  }
}
