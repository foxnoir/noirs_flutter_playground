import 'package:flutter_riverpod/flutter_riverpod.dart';

// Same Notifier class as the kept-alive provider. autoDispose drops it when
// the last watcher is gone (Back). Next visit: new notifier, build() → '-'.
final lifetimesAutoDisposeProvider =
    NotifierProvider.autoDispose<LifetimesAutoDisposeNotifier, String>(
      LifetimesAutoDisposeNotifier.new,
    );

class LifetimesAutoDisposeNotifier extends Notifier<String> {
  @override
  String build() => '-';

  void setUser(String user) => state = user.trim();
}
