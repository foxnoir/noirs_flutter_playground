import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/errors/app_exception.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/tick/data/data_sources/in_memory_tick_data_source.dart';
import 'package:riverpod_basics/features/labs/tick/domain/entities/tick.dart';
import 'package:riverpod_basics/features/labs/tick/domain/repositories/tick_repository.dart';

final tickRepositoryProvider = Provider<TickRepository>((ref) {
  return InMemoryTickRepository(ref.watch(tickDataSourceProvider));
});

/// Maps models → entities and AppException → AppFailure.
class InMemoryTickRepository implements TickRepository {
  const InMemoryTickRepository(this._dataSource);

  final TickDataSource _dataSource;

  @override
  Stream<Tick> watchTicks() {
    return _dataSource
        .watchTicks()
        .map((model) => model.toEntity())
        .handleError((Object error, StackTrace stack) {
          Error.throwWithStackTrace(
            error is AppException ? AppFailure.fromException(error) : error,
            stack,
          );
        });
  }

  @override
  void failCall() => _dataSource.failCall();
}
