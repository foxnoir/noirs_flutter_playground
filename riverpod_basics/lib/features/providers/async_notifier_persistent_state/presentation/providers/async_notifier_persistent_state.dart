import 'package:flutter_riverpod/flutter_riverpod.dart';

// No autoDispose: in-memory for ProviderScope (the app), not disk.
// Leave the page and come back — same notifier, same count, no loading.
final persistentStateAsyncNotifierProvider =
    AsyncNotifierProvider<PersistentStateAsyncNotifier, int>(
      PersistentStateAsyncNotifier.new,
    );

// Thrown on every 3rd page enter so `when(error:)` has something to show.
class FakePageEnterException implements Exception {
  const FakePageEnterException(this.visitCount);

  final int visitCount;
}

// AsyncNotifier is a Notifier whose state is AsyncValue<T>: loading, error, data.
// Use it when the first value (or an update) comes from a Future.
// The <int> is the payload: state is AsyncValue<int>, future is Future<int>.
class PersistentStateAsyncNotifier extends AsyncNotifier<int> {
  // How many times the screen called onPageEntered(). Survives Back
  // because this notifier is not autoDispose.
  int _pageEnterCount = 0;

  // Last successful count. Visit 4 restores this after a fake error.
  int _count = 0;

  // First read. Riverpod sets state to AsyncLoading. The value you return
  // becomes state: return 0 → AsyncData(0). Throw → AsyncError.
  @override
  Future<int> build() async {
    // Stands in for a repository/API Future so the UI can show loading.
    // This Future.delayed is Dart's timer, not the `future` getter below.
    final result = await Future.delayed(const Duration(seconds: 3), () => 0);
    _count = result;
    return result;
  }

  // build() does not run again on later visits (no autoDispose). The
  // screen calls this once per enter. Visit 3, 6, 9, … → fake error.
  Future<void> onPageEntered() async {
    _pageEnterCount++;
    final enter = _pageEnterCount;

    if (enter % 3 != 0) {
      // Leave the error page and come back: show the persisted count.
      if (state.hasError) {
        state = AsyncData(_count);
      }
      return;
    }

    state = const AsyncLoading();
    // guard: Future ok → AsyncData, throw / Future.error → AsyncError.
    // Without guard you write the try/catch yourself:
    //   try {
    //     await Future<void>.delayed(const Duration(seconds: 3));
    //     throw FakePageEnterException(enter);
    //   } catch (err, stack) {
    //     state = AsyncError(err, stack);
    //   }
    final next = await AsyncValue.guard(() async {
      await Future<void>.delayed(const Duration(seconds: 3));
      throw FakePageEnterException(enter);
    });
    // User left during the delay; a newer enter owns state now.
    if (enter != _pageEnterCount) {
      return;
    }
    state = next;
  }

  // Same notifier instance the screen got via provider.notifier.
  // `future` unwraps this object's state (the int from build, or a later
  // AsyncData). It is not a handle to the Future.delayed in build().
  // Assigning `state` notifies every `ref.watch`.
  Future<void> increment() async {
    final current = await future;
    _count = current + 1;
    state = AsyncData(_count);
  }

  Future<void> decrement() async {
    final current = await future;
    _count = current - 1;
    state = AsyncData(_count);
  }

  // Reload on this page. Back does not dispose this provider (no autoDispose).
  // Assigning AsyncLoading notifies watchers now. invalidate() does not:
  // when() keeps showing data on refresh (skipLoadingOnRefresh).
  Future<void> reset() async {
    state = const AsyncLoading();
    // guard maps the Future to AsyncValue: 0 → AsyncData(0), throw → AsyncError.
    // Manual equivalent:
    //   final result = await Future.delayed(const Duration(seconds: 3), () => 0);
    //   _count = result;
    //   state = AsyncData(result);
    state = await AsyncValue.guard(() async {
      final result = await Future.delayed(const Duration(seconds: 3), () => 0);
      _count = result;
      return result;
      // Fake a failed reset instead of 0:
      // throw Exception('error reset the state');
    });
  }
}
