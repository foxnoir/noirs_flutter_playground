import 'package:riverpod_basics/core/errors/app_exception.dart';
import 'package:riverpod_basics/features/labs/tick/data/data_sources/in_memory_tick_data_source.dart';
import 'package:riverpod_basics/features/labs/tick/data/models/tick_model.dart';

class FakeTickDataSource implements TickDataSource {
  FakeTickDataSource({this.models = const [], this.error});

  final List<TickModel> models;
  final AppException? error;

  @override
  Stream<TickModel> watchTicks() async* {
    yield* Stream.fromIterable(models);
    final thrown = error;
    if (thrown != null) {
      throw thrown;
    }
  }

  @override
  void failCall() {}
}
