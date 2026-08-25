import 'package:flutter_riverpod/flutter_riverpod.dart';

// No autoDispose: in-memory for ProviderScope (the app), not disk.
// Leave Add User and come back — same notifier, same username.
final addUserProvider = NotifierProvider<AddUserNotifier, String>(
  AddUserNotifier.new,
);

class AddUserNotifier extends Notifier<String> {
  @override
  String build() => '-';

  String get user => state;
  set user(String user) => state = user;
}
