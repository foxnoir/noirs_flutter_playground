import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/errors/app_exception.dart';
import 'package:riverpod_basics/features/labs/tick/data/models/tick_model.dart';

abstract interface class TickDataSource {
  Stream<TickModel> watchTicks();

  void failCall();
}

/// Gap between fake /tick events. Must be > 0 — [Duration.zero] would spin.
/// Tests that need a finite stream fake the repository instead.
final tickIntervalProvider = Provider<Duration>((ref) {
  return const Duration(milliseconds: 800);
});

final tickDataSourceProvider = Provider<InMemoryTickDataSource>((ref) {
  final source = InMemoryTickDataSource(
    interval: ref.watch(tickIntervalProvider),
  );
  ref.onDispose(source.dispose);
  return source;
});

/// Fake stream /tick. Throws AppException, never AppFailure.
/// [Timer.periodic] lives on this instance so [dispose] / stream cancel
/// can stop it. autoDispose on the StreamProvider is not enough by itself
/// if the repository wraps the stream in `async*`.
class InMemoryTickDataSource implements TickDataSource {
  InMemoryTickDataSource({required Duration interval}) : _interval = interval {
    if (interval <= Duration.zero) {
      throw ArgumentError.value(
        interval,
        'interval',
        'must be greater than zero',
      );
    }
  }

  final Duration _interval;
  var _failCall = false;
  Timer? _timer;

  /// Next tick throws [NetworkException], then clears. The controller closes.
  @override
  void failCall() => _failCall = true;

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Stream<TickModel> watchTicks() {
    var n = 0;
    dispose();
    late final StreamController<TickModel> controller;

    void emit() {
      try {
        if (_failCall) {
          _failCall = false;
          dispose();
          controller
            ..addError(const NetworkException())
            ..close();
          return;
        }
        n += 1;
        controller.add(TickModel(n: n, emittedAt: DateTime.now()));
      } on AppException catch (error) {
        dispose();
        controller
          ..addError(error)
          ..close();
      } catch (_) {
        dispose();
        controller
          ..addError(const NetworkException())
          ..close();
      }
    }

    controller = StreamController<TickModel>(
      onListen: () {
        _timer = Timer.periodic(_interval, (_) => emit());
      },
      onCancel: dispose,
    );

    return controller.stream;
  }
}
