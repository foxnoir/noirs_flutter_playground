import 'package:fake_async/fake_async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/providers/lifetimes_keep_alive_provider.dart';

void main() {
  void pumpDispose(FakeAsync async, ProviderContainer container) {
    container.pump();
    async.flushMicrotasks();
  }

  test('lifetimesKeepAliveProvider keeps state for 5s after last listener', () {
    fakeAsync((async) {
      final container = ProviderContainer.test();
      addTearDown(container.dispose);

      final sub = container.listen(lifetimesKeepAliveProvider, (_, _) {});

      expect(container.read(lifetimesKeepAliveProvider), '-');
      container.read(lifetimesKeepAliveProvider.notifier).setUser('Ada');
      expect(container.read(lifetimesKeepAliveProvider), 'Ada');

      sub.close();
      pumpDispose(async, container);

      expect(container.exists(lifetimesKeepAliveProvider), isTrue);

      async.elapse(keepAliveDuration - const Duration(milliseconds: 1));
      pumpDispose(async, container);
      expect(container.exists(lifetimesKeepAliveProvider), isTrue);

      async.elapse(const Duration(milliseconds: 1));
      pumpDispose(async, container);
      expect(container.exists(lifetimesKeepAliveProvider), isFalse);

      final next = container.listen(lifetimesKeepAliveProvider, (_, _) {});
      addTearDown(next.close);

      expect(container.read(lifetimesKeepAliveProvider), '-');
    });
  });

  test('onResume cancels the timer so a return before 5s keeps Ada', () {
    fakeAsync((async) {
      final container = ProviderContainer.test();
      addTearDown(container.dispose);

      var sub = container.listen(lifetimesKeepAliveProvider, (_, _) {});
      container.read(lifetimesKeepAliveProvider.notifier).setUser('Ada');
      sub.close();
      pumpDispose(async, container);

      async.elapse(const Duration(seconds: 4));
      pumpDispose(async, container);
      expect(container.exists(lifetimesKeepAliveProvider), isTrue);

      // Back on the screen: onResume cancels the remaining 1s.
      sub = container.listen(lifetimesKeepAliveProvider, (_, _) {});
      expect(container.read(lifetimesKeepAliveProvider), 'Ada');

      async.elapse(const Duration(seconds: 5));
      pumpDispose(async, container);
      expect(container.exists(lifetimesKeepAliveProvider), isTrue);
      expect(container.read(lifetimesKeepAliveProvider), 'Ada');

      sub.close();
      pumpDispose(async, container);
      async.elapse(keepAliveDuration);
      pumpDispose(async, container);
      expect(container.exists(lifetimesKeepAliveProvider), isFalse);
    });
  });

  test('emits resume then dispose notices', () {
    fakeAsync((async) {
      final container = ProviderContainer.test();
      addTearDown(container.dispose);

      final notices = <KeepAliveLifecycle>[];
      container.listen(keepAliveNoticeProvider, (_, next) {
        if (next != null) {
          notices.add(next.lifecycle);
        }
      });

      final sub = container.listen(lifetimesKeepAliveProvider, (_, _) {});
      container.read(lifetimesKeepAliveProvider.notifier).setUser('Ada');
      sub.close();
      pumpDispose(async, container);
      expect(notices, isEmpty);

      final resumed = container.listen(lifetimesKeepAliveProvider, (_, _) {});
      pumpDispose(async, container);
      async.flushMicrotasks();
      expect(notices, [KeepAliveLifecycle.resume]);

      resumed.close();
      async.elapse(keepAliveDuration);
      pumpDispose(async, container);
      async.flushMicrotasks();
      expect(notices, [KeepAliveLifecycle.resume, KeepAliveLifecycle.dispose]);
    });
  });
}
