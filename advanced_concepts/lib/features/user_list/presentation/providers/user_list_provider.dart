import 'package:advanced_concepts/features/user_list/data/repositories/in_memory_user_list_repository.dart';
import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userListProvider = AsyncNotifierProvider<UserListNotifier, List<User>>(
  UserListNotifier.new,
);

class UserListNotifier extends AsyncNotifier<List<User>> {
  @override
  Future<List<User>> build() {
    return ref.watch(userListRepositoryProvider).fetchUsers();
  }

  Future<void> retry() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(userListRepositoryProvider).fetchUsers(),
    );
  }
}
