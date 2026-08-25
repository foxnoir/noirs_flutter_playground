import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/add_user/data/repositories/in_memory_user_repository.dart';
import 'package:riverpod_basics/features/labs/add_user/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/providers/user_state.dart';

const duplicateUserIdError = 'duplicateId';
const fetchUsersError = 'fetchUsers';

final addUserProvider = NotifierProvider<AddUserNotifier, UserState>(
  AddUserNotifier.new,
);

class AddUserNotifier extends Notifier<UserState> {
  @override
  UserState build() => const UserState();

  Future<void> fetchUsers() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final users = await ref.read(userRepositoryProvider).fetchUsers();
      state = state.copyWith(isLoading: false, users: users);
    } on Object {
      state = state.copyWith(isLoading: false, error: fetchUsersError);
    }
  }

  void addUser(User user) {
    if (state.users.any((existing) => existing.id == user.id)) {
      state = state.copyWith(isAdded: false, error: duplicateUserIdError);
      return;
    }

    state = state.copyWith(
      isAdded: true,
      error: null,
      users: [...state.users, user],
    );
  }

  void acknowledgeAdded() {
    state = state.copyWith(isAdded: false);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
