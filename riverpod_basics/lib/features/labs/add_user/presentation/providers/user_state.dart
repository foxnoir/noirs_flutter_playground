import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_basics/features/labs/add_user/domain/entities/user.dart';

part 'user_state.freezed.dart';

// Screen snapshot for Add User — not a `User`, not a Riverpod type.
//
// A read-only `Provider<List<User>>` cannot add or fetch. `Notifier<List<User>>`
// holds only the list: loading, fetch errors, and the one-shot "added" flag
// would need extra providers. `AsyncValue<List<User>>` is loading / error /
// data, but has no `isAdded` for the SnackBar, and `addUser` is synchronous.
// One Freezed `UserState` is one `copyWith` and one `ref.watch`.
@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    @Default(false) bool isLoading,
    // One-shot. `ref.listen` shows the SnackBar, then `acknowledgeAdded()`.
    @Default(false) bool isAdded,
    String? error,
    @Default(<User>[]) List<User> users,
  }) = _UserState;
}
