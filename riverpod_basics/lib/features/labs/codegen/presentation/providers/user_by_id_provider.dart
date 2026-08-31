import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_basics/core/errors/app_exception.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/user_list/data/repositories/in_memory_user_list_repository.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';

part 'user_by_id_provider.g.dart';

// Family: one template, many mailboxes. `userByIdProvider(10)` and
// `userByIdProvider(11)` are two caches. The argument is part of the key.
//
// `build()` already maps return → AsyncData and throw → AsyncError.
// `reload()` is a later GET, so wrap it with AsyncValue.guard (same as
// the AsyncNotifier screens). guard does not set loading.

@riverpod
class UserById extends _$UserById {
  @override
  Future<User> build(int id) async {
    final users = await ref.watch(userListRepositoryProvider).fetchUsers();
    return _userWithId(users, id);
  }

  Future<void> reload() async {
    // guard: Future ok → AsyncData, throw → AsyncError. Not loading.
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final users = await ref.read(userListRepositoryProvider).fetchUsers();
      return _userWithId(users, id);
    });
  }
}

User _userWithId(List<User> users, int id) {
  for (final user in users) {
    if (user.id == id) return user;
  }
  // No data source for this lookup. A real GET /users/99 would throw
  // NotFoundException in the source; the repository would map it.
  throw AppFailure.fromException(const NotFoundException());
}
