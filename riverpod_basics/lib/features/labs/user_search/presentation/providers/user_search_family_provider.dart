import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_provider.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/providers/user_search_provider.dart';

part 'user_search_family_provider.g.dart';

// Family is not a second search feature and not "pass a param".
// The extra `String query` on this @riverpod function is how codegen
// makes a Family. You do not type `.family` here; the generator does
// (see user_search_family_provider.g.dart). The handwritten twin is
// user_search_family_provider_manual.dart (not imported).
//
// Named userSearchFamily so the generated `userSearchFamilyProvider`
// does not clash with `userSearchProvider`, and so the lab label can
// say Family. Same filter as the Notifier.
//
// `userSearchFamilyProvider('Grace')` and `('10')` are two caches.
// No UserSearchState and no _token: AsyncValue is loading/data/error,
// and a new query watches a different provider.

@riverpod
Future<List<User>> userSearchFamily(Ref ref, String query) async {
  await Future<void>.delayed(ref.watch(userSearchDelayProvider));
  if (!ref.mounted) return const [];

  await ref.read(userListProvider.notifier).ensureLoaded();
  if (!ref.mounted) return const [];

  return usersMatchingQuery(ref.read(userListProvider).users, query);
}
