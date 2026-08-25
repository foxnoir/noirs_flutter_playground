import 'package:flutter_riverpod/flutter_riverpod.dart';

// No autoDispose: in-memory for ProviderScope (the app), not disk.
// Leave Provider Lifetimes and come back — same notifier, same username.
final lifetimesPersistentProvider =
    NotifierProvider<LifetimesPersistentNotifier, String>(
      LifetimesPersistentNotifier.new,
    );

class LifetimesPersistentNotifier extends Notifier<String> {
  @override
  String build() => '-';

  String get user => state;
  set user(String user) => state = user;
}
