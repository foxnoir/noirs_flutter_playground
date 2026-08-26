import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 400ms so the spinner is visible. Tests set this to [Duration.zero].
final refreshPingDelayProvider = Provider<Duration>(
  (ref) => const Duration(milliseconds: 400),
);

/// How many times the fake GET has *started*. Keep-alive so a refresh of
/// [refreshPingProvider] does not reset the count to 1.
final refreshPingCountProvider = Provider<RefreshPingCounter>(
  (ref) => RefreshPingCounter(),
);

/// Fake GET /ping. `ref.refresh(refreshPingProvider)` / `invalidate`
/// run **this function** again. You name the provider, not `.next()`.
final refreshPingProvider = FutureProvider<RefreshPing>((ref) async {
  // Count at start, not after the delay, so three refresh() calls in one
  // tap increment three times even if only the last GET is shown.
  final counter = ref.read(refreshPingCountProvider);
  final n = counter.next();
  await Future<void>.delayed(ref.watch(refreshPingDelayProvider));
  return RefreshPing(n: n, fetchedAt: DateTime.now());
});

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
