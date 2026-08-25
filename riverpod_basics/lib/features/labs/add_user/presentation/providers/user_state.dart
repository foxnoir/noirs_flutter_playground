import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

// Form snapshot for Add User — not the user list.
//
// The list lives on `userListProvider` in the User List feature. This class
// is only the one-shot SnackBar flag and the duplicate-id error. One
// `copyWith` replaces `state`. `ref.listen` on `isAdded` / `error` for
// side effects.
@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    // One-shot. `ref.listen` shows the SnackBar, then `acknowledgeAdded()`.
    @Default(false) bool isAdded,
    String? error,
  }) = _UserState;
}
