import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Playground, not a production cache. autoDispose would drop the name on
// Back. keepAlive + a 5s timer lets you feel onCancel / onResume / onDispose
// on the same screen as Persistent (never dies) and Non-Persistent (dies now).
const addUserKeepAliveDuration = Duration(seconds: 5);

const addUserKeepAliveSnackBarDuration = Duration(milliseconds: 1500);

enum AddUserKeepAliveLifecycle { resume, dispose }

class AddUserKeepAliveNotice {
  AddUserKeepAliveNotice(this.lifecycle);

  final AddUserKeepAliveLifecycle lifecycle;
}

final addUserKeepAliveNoticeProvider =
    NotifierProvider<AddUserKeepAliveNoticeNotifier, AddUserKeepAliveNotice?>(
      AddUserKeepAliveNoticeNotifier.new,
    );

class AddUserKeepAliveNoticeNotifier extends Notifier<AddUserKeepAliveNotice?> {
  @override
  AddUserKeepAliveNotice? build() => null;

  void emit(AddUserKeepAliveLifecycle lifecycle) {
    state = AddUserKeepAliveNotice(lifecycle);
  }
}

final addUserKeepAliveProvider =
    NotifierProvider.autoDispose<AddUserKeepAliveNotifier, String>(
      AddUserKeepAliveNotifier.new,
    );

void _notifyKeepAliveLifecycle(
  ProviderContainer container,
  AddUserKeepAliveLifecycle lifecycle,
) {
  // Life-cycle callbacks cannot write other providers. Defer until the stack is clear.
  scheduleMicrotask(() {
    container.read(addUserKeepAliveNoticeProvider.notifier).emit(lifecycle);
  });
}

class AddUserKeepAliveNotifier extends Notifier<String> {
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
      timer = Timer(addUserKeepAliveDuration, () {
        _notifyKeepAliveLifecycle(container, AddUserKeepAliveLifecycle.dispose);
        keepAlive.close();
      });
    });

    // Watched again before the timer fired (back on this screen).
    // Cancel so the old 5s cannot close() while we are looking, and so
    // the next Back gets a fresh 5s.
    ref.onResume(() {
      timer?.cancel();
      debugPrint('AddUserKeepAlive: onResume (Timer stopped)');
      _notifyKeepAliveLifecycle(container, AddUserKeepAliveLifecycle.resume);
    });

    // Provider is actually gone. Drop a timer that never got to fire.
    ref.onDispose(() {
      timer?.cancel();
      debugPrint('AddUserKeepAlive: onDispose');
    });

    return '-';
  }

  String get user => state;
  set user(String user) => state = user;
}
