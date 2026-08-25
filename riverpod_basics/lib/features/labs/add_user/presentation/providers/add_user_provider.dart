import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/providers/user_state.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_provider.dart';

const duplicateUserIdError = 'duplicateId';
const duplicateEmailError = 'duplicateEmail';

final addUserProvider = NotifierProvider<AddUserNotifier, UserState>(
  AddUserNotifier.new,
);

class AddUserNotifier extends Notifier<UserState> {
  @override
  UserState build() => const UserState();

  void addUser(User user) {
    switch (ref.read(userListProvider.notifier).addUser(user)) {
      case AddUserResult.added:
        state = state.copyWith(isAdded: true, error: null);
      case AddUserResult.duplicateId:
        state = state.copyWith(isAdded: false, error: duplicateUserIdError);
      case AddUserResult.duplicateEmail:
        state = state.copyWith(isAdded: false, error: duplicateEmailError);
    }
  }

  void acknowledgeAdded() {
    state = state.copyWith(isAdded: false);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
