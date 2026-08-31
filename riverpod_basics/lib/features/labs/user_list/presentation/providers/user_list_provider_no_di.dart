import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/user_list/data/repositories/hard_wired_user_list_repository.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_state.dart';

/// Not imported. Same notifier as UserListNotifier, but it builds
/// HardWiredUserListRepository itself. No `userListRepositoryProvider`, no
/// interface. Tests cannot swap a Fake in.

final userListNoDiProvider =
    NotifierProvider<UserListNotifierNoDi, UserListState>(
      UserListNotifierNoDi.new,
    );

class UserListNotifierNoDi extends Notifier<UserListState> {
  @override
  UserListState build() => const UserListState();

  Future<void> fetchUsers() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final users = await const HardWiredUserListRepository().fetchUsers();
      state = state.copyWith(isLoading: false, users: users);
    } on AppFailure catch (failure) {
      state = state.copyWith(isLoading: false, error: failure);
    }
  }
}
