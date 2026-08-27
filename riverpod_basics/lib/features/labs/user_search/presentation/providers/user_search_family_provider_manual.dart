import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_provider.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/providers/user_search_provider.dart';

// Not imported. Same mailbox as user_search_family_provider.dart, by hand.
// This is the line codegen hides: FutureProvider.autoDispose.family.
// Family = query is on the key. Not "easier parameters" and not a token.

final userSearchFamilyProvider = FutureProvider.autoDispose
    .family<List<User>, String>((ref, query) async {
      await Future<void>.delayed(ref.watch(userSearchDelayProvider));
      if (!ref.mounted) return const [];

      await ref.read(userListProvider.notifier).ensureLoaded();
      if (!ref.mounted) return const [];

      return usersMatchingQuery(ref.read(userListProvider).users, query);
    });
