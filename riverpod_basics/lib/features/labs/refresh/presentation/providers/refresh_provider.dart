import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 400ms so the spinner is visible. Tests set this to [Duration.zero].
final refreshPingDelayProvider = Provider<Duration>(
  (ref) => const Duration(milliseconds: 400),
);

/// Fake GET /ping. `ref.refresh(refreshPingProvider)` / `invalidate`
/// run **this function** again. You name the provider, not a method.
final refreshPingProvider = FutureProvider<DateTime>((ref) async {
  await Future<void>.delayed(ref.watch(refreshPingDelayProvider));
  return DateTime.now();
});
