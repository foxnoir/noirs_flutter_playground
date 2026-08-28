import 'package:riverpod_basics/features/labs/tick/domain/entities/tick.dart';

/// DTO from the fake /tick stream. The repository maps this to [Tick]
/// with [toEntity].
class TickModel {
  const TickModel({required this.n, required this.emittedAt});

  final int n;
  final DateTime emittedAt;

  Tick toEntity() => Tick(n: n, emittedAt: emittedAt);
}
