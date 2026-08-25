import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';

part 'user_list_state.freezed.dart';

// The user list snapshot. Add User writes here; both screens read it.
@freezed
abstract class UserListState with _$UserListState {
  const factory UserListState({
    @Default(false) bool isLoading,
    String? error,
    @Default(<User>[]) List<User> users,
  }) = _UserListState;
}
