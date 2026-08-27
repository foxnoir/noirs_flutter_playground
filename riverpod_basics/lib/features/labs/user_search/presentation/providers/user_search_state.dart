import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';

part 'user_search_state.freezed.dart';

/// Snapshot for the command-style search (one mailbox).
/// Family has no class like this: its state is AsyncValue.
@freezed
abstract class UserSearchState with _$UserSearchState {
  const factory UserSearchState({
    @Default(false) bool isSearching,
    @Default(false) bool hasSearched,
    @Default(<User>[]) List<User> matches,
  }) = _UserSearchState;
}
