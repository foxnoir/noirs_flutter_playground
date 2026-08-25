import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/user_list/data/repositories/in_memory_user_repository.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_state.dart';

const fetchUsersError = 'fetchUsers';

final userListProvider = NotifierProvider<UserListNotifier, UserListState>(
  UserListNotifier.new,
);

class UserListNotifier extends Notifier<UserListState> {
  @override
  UserListState build() => const UserListState();

  Future<void> ensureLoaded() async {
    if (state.users.isNotEmpty || state.isLoading) return;
    await fetchUsers();
  }

  Future<void> fetchUsers() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final users = await ref.read(userRepositoryProvider).fetchUsers();
      state = state.copyWith(isLoading: false, users: users);
    } on Object {
      state = state.copyWith(isLoading: false, error: fetchUsersError);
    }
  }

  bool addUser(User user) {
    if (state.users.any((existing) => existing.id == user.id)) {
      return false;
    }

    state = state.copyWith(users: [...state.users, user]);
    return true;
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
