/// Fake stream /tick payload. Not a Freezed screen state.
class Tick {
  const Tick({required this.n, required this.emittedAt});

  final int n;
  final DateTime emittedAt;
}
