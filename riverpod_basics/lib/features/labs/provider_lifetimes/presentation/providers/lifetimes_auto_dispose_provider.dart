import 'package:flutter_riverpod/flutter_riverpod.dart';

// Same Notifier class as the kept-alive provider. autoDispose drops it when
// the last watcher is gone (Back). Next visit: new notifier, build() → '-'.
final addUserNonPersistentProvider =
    NotifierProvider.autoDispose<AddUserNonPersistentNotifier, String>(
      AddUserNonPersistentNotifier.new,
    );

class AddUserNonPersistentNotifier extends Notifier<String> {
  @override
  String build() => '-';

  String get user => state;
  set user(String user) => state = user;
}
