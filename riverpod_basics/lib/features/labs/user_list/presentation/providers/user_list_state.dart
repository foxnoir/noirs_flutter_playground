import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';

part 'user_list_state.freezed.dart';

// The user list snapshot. Add User writes here; User List and User Search
// read it. `error` is AppFailure?, not a raw string — UI maps via l10n.
// `error` is AppFailure?, not a raw string — UI maps via l10n.
@freezed
abstract class UserListState with _$UserListState {
  const factory UserListState({
    @Default(false) bool isLoading,
    AppFailure? error,
    @Default(<User>[]) List<User> users,
  }) = _UserListState;
}
