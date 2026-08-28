import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/tick/domain/entities/tick.dart';
import 'package:riverpod_basics/features/labs/tick/domain/repositories/tick_repository.dart';

/// Repository fake: already past the data-source boundary, so it throws
/// AppFailure, not AppException.
class FakeTickRepository implements TickRepository {
  FakeTickRepository({this.ticks = const [], this.error, this.stream});

  final List<Tick> ticks;
  final AppFailure? error;
  final Stream<Tick>? stream;
  int watchCalls = 0;

  @override
  Stream<Tick> watchTicks() {
    watchCalls++;
    if (stream != null) {
      return stream!;
    }
    final thrown = error;
    if (thrown != null) {
      return Stream.error(thrown);
    }
    return Stream.fromIterable(ticks);
  }

  @override
  void failCall() {}
}
