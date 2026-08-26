import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'refresh_provider.g.dart';

// `@riverpod` is autoDispose. The count must survive a refresh of the ping,
// so it uses `@Riverpod(keepAlive: true)`.

/// 400ms so the spinner is visible. Tests set this to [Duration.zero].
@riverpod
Duration refreshPingDelay(Ref ref) {
  return const Duration(milliseconds: 400);
}

/// How many times the fake GET has *started*. Keep-alive so a refresh of
/// [refreshPingProvider] does not reset the count to 1.
@Riverpod(keepAlive: true)
RefreshPingCounter refreshPingCount(Ref ref) {
  return RefreshPingCounter();
}

/// Fake GET /ping. `ref.refresh(refreshPingProvider)` / `invalidate`
/// run **this function** again. You name the provider, not `.next()`.
@riverpod
Future<RefreshPing> refreshPing(Ref ref) async {
  // Count at start, not after the delay, so three refresh() calls in one
  // tap increment three times even if only the last GET is shown.
  final counter = ref.read(refreshPingCountProvider);
  final n = counter.next();
  await Future<void>.delayed(ref.watch(refreshPingDelayProvider));
  return RefreshPing(n: n, fetchedAt: DateTime.now());
}

class RefreshPing {
  const RefreshPing({required this.n, required this.fetchedAt});

  final int n;
  final DateTime fetchedAt;
}

class RefreshPingCounter {
  var _replies = 0;

  /// Called when the GET function *starts*, not from the Refresh button.
  int next() => ++_replies;
}
