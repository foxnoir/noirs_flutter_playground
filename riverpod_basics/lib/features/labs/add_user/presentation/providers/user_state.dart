import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_basics/features/labs/add_user/domain/entities/user.dart';

part 'user_state.freezed.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    @Default(false) bool isLoading,
    @Default(false) bool isAdded,
    String? error,
    @Default(<User>[]) List<User> users,
  }) = _UserState;
}
