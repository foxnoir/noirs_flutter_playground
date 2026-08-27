import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_provider.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/providers/user_search_state.dart';

/// Fake GET /search latency. Tests override this to [Duration.zero].
/// Shared by the Notifier (`search()`) and the Family provider.
final userSearchDelayProvider = Provider<Duration>((ref) {
  return const Duration(milliseconds: 450);
});

/// One mailbox. `search(query)` is a command, not Family.
///
/// Family is not "easier parameters". This method already takes a query.
/// Family means the argument is part of the **key**: many providers from
/// one template. Here there is one slot; each `search()` overwrites it.
///
/// `_token` is only for that one slot: a slow search must not write after
/// a newer one. Family does not need a token because each query is its
/// own provider. That is a side effect, not why Family exists.
final userSearchProvider =
    NotifierProvider.autoDispose<UserSearchNotifier, UserSearchState>(
      UserSearchNotifier.new,
    );

class UserSearchNotifier extends Notifier<UserSearchState> {
  // Bumps when a newer search starts. Stale Futures return without writing.
  var _token = 0;

  @override
  UserSearchState build() => const UserSearchState();

  /// Fake search: delay, then filter the shared user list.
  Future<void> search(String rawQuery) async {
    final query = rawQuery.trim();
    if (query.isEmpty) {
      _token++;
      state = const UserSearchState();
      return;
    }

    final token = ++_token;
    state = const UserSearchState(isSearching: true);

    await Future<void>.delayed(ref.read(userSearchDelayProvider));
    if (token != _token || !ref.mounted) return;

    await ref.read(userListProvider.notifier).ensureLoaded();
    if (token != _token || !ref.mounted) return;

    state = UserSearchState(
      hasSearched: true,
      matches: usersMatchingQuery(ref.read(userListProvider).users, query),
    );
  }
}

List<User> usersMatchingQuery(List<User> users, String query) {
  final needle = query.trim().toLowerCase();
  if (needle.isEmpty) return const [];

  return [
    for (final user in users)
      if (user.username.toLowerCase().contains(needle) ||
          user.id.toString() == needle)
        user,
  ];
}
