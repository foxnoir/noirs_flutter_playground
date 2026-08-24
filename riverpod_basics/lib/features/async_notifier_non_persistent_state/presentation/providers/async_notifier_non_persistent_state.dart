import 'package:flutter_riverpod/flutter_riverpod.dart';

// autoDispose: last watcher gone (back to landing) → provider disposed.
// Open the page again → build() runs, loading, count is 0.
final nonPersistentStateAsyncNotifierProvider =
    AsyncNotifierProvider.autoDispose<NonPersistentStateAsyncNotifier, int>(
      NonPersistentStateAsyncNotifier.new,
    );

// AsyncNotifier is a Notifier whose state is AsyncValue<T>: loading, error, data.
// Use it when the first value (or an update) comes from a Future.
class NonPersistentStateAsyncNotifier extends AsyncNotifier<int> {
  // First read. Riverpod sets state to AsyncLoading, then AsyncData or AsyncError.
  @override
  Future<int> build() async {
    // Stands in for a repository/API Future so the UI can show loading.
    final result = await Future.delayed(const Duration(seconds: 3), () => 0);
    return result;
  }

  // `await future` is the current int once loading finishes.
  // Assigning `state` notifies every `ref.watch`.
  Future<void> increment() async {
    final current = await future;
    state = AsyncData(current + 1);
  }

  Future<void> decrement() async {
    final current = await future;
    state = AsyncData(current - 1);
  }

  // Assigning AsyncLoading notifies watchers now. invalidate() does not:
  // when() keeps showing data on refresh (skipLoadingOnRefresh).
  Future<void> reset() async {
    state = const AsyncLoading();
    // Same fake API as build(), so the spinner has something to wait for.
    final result = await Future.delayed(const Duration(seconds: 3), () => 0);
    state = AsyncData(result);
  }
}
