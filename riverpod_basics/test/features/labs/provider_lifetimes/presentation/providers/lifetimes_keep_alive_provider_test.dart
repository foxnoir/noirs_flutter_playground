import 'package:fake_async/fake_async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/providers/add_user_keep_alive_provider.dart';

void main() {
  void pumpDispose(FakeAsync async, ProviderContainer container) {
    container.pump();
    async.flushMicrotasks();
  }

  test('addUserKeepAliveProvider keeps state for 5s after last listener', () {
    fakeAsync((async) {
      final container = ProviderContainer.test();
      addTearDown(container.dispose);

      final sub = container.listen(addUserKeepAliveProvider, (_, _) {});

      expect(container.read(addUserKeepAliveProvider), '-');
      container.read(addUserKeepAliveProvider.notifier).user = 'Ada';
      expect(container.read(addUserKeepAliveProvider), 'Ada');

      sub.close();
      pumpDispose(async, container);

      expect(container.exists(addUserKeepAliveProvider), isTrue);

      async.elapse(addUserKeepAliveDuration - const Duration(milliseconds: 1));
      pumpDispose(async, container);
      expect(container.exists(addUserKeepAliveProvider), isTrue);

      async.elapse(const Duration(milliseconds: 1));
      pumpDispose(async, container);
      expect(container.exists(addUserKeepAliveProvider), isFalse);

      final next = container.listen(addUserKeepAliveProvider, (_, _) {});
      addTearDown(next.close);

      expect(container.read(addUserKeepAliveProvider), '-');
    });
  });

  test('onResume cancels the timer so a return before 5s keeps Ada', () {
    fakeAsync((async) {
      final container = ProviderContainer.test();
      addTearDown(container.dispose);

      var sub = container.listen(addUserKeepAliveProvider, (_, _) {});
      container.read(addUserKeepAliveProvider.notifier).user = 'Ada';
      sub.close();
      pumpDispose(async, container);

      async.elapse(const Duration(seconds: 4));
      pumpDispose(async, container);
      expect(container.exists(addUserKeepAliveProvider), isTrue);

      // Back on the screen: onResume cancels the remaining 1s.
      sub = container.listen(addUserKeepAliveProvider, (_, _) {});
      expect(container.read(addUserKeepAliveProvider), 'Ada');

      async.elapse(const Duration(seconds: 5));
      pumpDispose(async, container);
      expect(container.exists(addUserKeepAliveProvider), isTrue);
      expect(container.read(addUserKeepAliveProvider), 'Ada');

      sub.close();
      pumpDispose(async, container);
      async.elapse(addUserKeepAliveDuration);
      pumpDispose(async, container);
      expect(container.exists(addUserKeepAliveProvider), isFalse);
    });
  });

  test('emits resume then dispose notices', () {
    fakeAsync((async) {
      final container = ProviderContainer.test();
      addTearDown(container.dispose);

      final notices = <AddUserKeepAliveLifecycle>[];
      container.listen(addUserKeepAliveNoticeProvider, (_, next) {
        if (next != null) {
          notices.add(next.lifecycle);
        }
      });

      final sub = container.listen(addUserKeepAliveProvider, (_, _) {});
      container.read(addUserKeepAliveProvider.notifier).user = 'Ada';
      sub.close();
      pumpDispose(async, container);
      expect(notices, isEmpty);

      final resumed = container.listen(addUserKeepAliveProvider, (_, _) {});
      pumpDispose(async, container);
      async.flushMicrotasks();
      expect(notices, [AddUserKeepAliveLifecycle.resume]);

      resumed.close();
      async.elapse(addUserKeepAliveDuration);
      pumpDispose(async, container);
      async.flushMicrotasks();
      expect(notices, [
        AddUserKeepAliveLifecycle.resume,
        AddUserKeepAliveLifecycle.dispose,
      ]);
    });
  });
}
