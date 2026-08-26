import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_provider.dart';

/// Next id/email so a second tap is not a duplicate.
void addDemoUser(WidgetRef ref) {
  final users = ref.read(userListProvider).users;
  var nextId = 1;
  for (final user in users) {
    if (user.id >= nextId) {
      nextId = user.id + 1;
    }
  }
  ref
      .read(userListProvider.notifier)
      .addUser(
        User(
          id: nextId,
          username: 'Demo $nextId',
          age: 21,
          email: 'demo$nextId@example.com',
        ),
      );
}
