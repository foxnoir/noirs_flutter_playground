import 'package:riverpod_basics/features/labs/tick/domain/entities/tick.dart';

/// Throws AppFailure when the data source failed. No user-facing strings.
abstract interface class TickRepository {
  Stream<Tick> watchTicks();

  /// Next tick fails. Lab-only; the flag lives on the data source.
  void failCall();
}
