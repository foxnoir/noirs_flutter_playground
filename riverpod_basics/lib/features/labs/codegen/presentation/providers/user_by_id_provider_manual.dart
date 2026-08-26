import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/errors/app_exception.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/user_list/data/repositories/in_memory_user_repository.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';

// Not imported. Same mailbox as user_by_id_provider.dart, written by hand.
// Codegen drops this wiring: the family provider line, the constructor that
// stores `id`, and `extends AsyncNotifier<User>`. The GET and reload() body
// stay the same length either way.

final userByIdProvider = AsyncNotifierProvider.autoDispose
    .family<UserByIdNotifier, User, int>(UserByIdNotifier.new);

class UserByIdNotifier extends AsyncNotifier<User> {
  UserByIdNotifier(this.id);

  final int id;

  @override
  Future<User> build() async {
    final users = await ref.watch(userRepositoryProvider).fetchUsers();
    return _userWithId(users, id);
  }

  Future<void> reload() async {
    // guard: Future ok → AsyncData, throw → AsyncError. Not loading.
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final users = await ref.read(userRepositoryProvider).fetchUsers();
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
