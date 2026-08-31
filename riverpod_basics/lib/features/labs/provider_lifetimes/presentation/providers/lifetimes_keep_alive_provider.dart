import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Playground, not a production cache. autoDispose would drop the name on
// Back. keepAlive + a 5s timer lets you feel onCancel / onResume / onDispose
// on the same screen as Persistent (never dies) and Non-Persistent (dies now).
const keepAliveDuration = Duration(seconds: 5);

const keepAliveSnackBarDuration = Duration(milliseconds: 1500);

enum KeepAliveLifecycle { resume, dispose }

class KeepAliveNotice {
  KeepAliveNotice(this.lifecycle);

  final KeepAliveLifecycle lifecycle;
}

final keepAliveNoticeProvider =
    NotifierProvider<KeepAliveNoticeNotifier, KeepAliveNotice?>(
      KeepAliveNoticeNotifier.new,
    );

class KeepAliveNoticeNotifier extends Notifier<KeepAliveNotice?> {
  @override
  KeepAliveNotice? build() => null;

  void emit(KeepAliveLifecycle lifecycle) {
    state = KeepAliveNotice(lifecycle);
  }
}

final lifetimesKeepAliveProvider =
    NotifierProvider.autoDispose<LifetimesKeepAliveNotifier, String>(
      LifetimesKeepAliveNotifier.new,
    );

void _notifyKeepAliveLifecycle(
  ProviderContainer container,
  KeepAliveLifecycle lifecycle,
) {
  // Life-cycle callbacks cannot write other providers. Defer until the stack is clear.
  scheduleMicrotask(() {
    container.read(keepAliveNoticeProvider.notifier).emit(lifecycle);
  });
}

class LifetimesKeepAliveNotifier extends Notifier<String> {
  @override
  String build() {
    // "Do not dispose yet." Closing the link later lets autoDispose run
    // if nobody is watching.
    final keepAlive = ref.keepAlive();
    final container = ref.container;
    Timer? timer;

    // Last watcher gone (Back). State is paused, not dead.
    // One-shot Timer — not periodic; we only want one close().
    // Notify before close() so the 1.5s SnackBar can show on the landing page.
    ref.onCancel(() {
      timer = Timer(keepAliveDuration, () {
        _notifyKeepAliveLifecycle(container, KeepAliveLifecycle.dispose);
        keepAlive.close();
      });
    });

    // Watched again before the timer fired (back on this screen).
    // Cancel so the old 5s cannot close() while we are looking, and so
    // the next Back gets a fresh 5s.
    ref.onResume(() {
      timer?.cancel();
      debugPrint('KeepAlive: onResume (Timer stopped)');
      _notifyKeepAliveLifecycle(container, KeepAliveLifecycle.resume);
    });

    // Provider is actually gone. Drop a timer that never got to fire.
    ref.onDispose(() {
      timer?.cancel();
      debugPrint('KeepAlive: onDispose');
    });

    return '-';
  }

  void setUser(String user) => state = user.trim();
}
