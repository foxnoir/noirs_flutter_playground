import 'package:advanced_concepts/features/user_list/data/repositories/in_memory_user_list_repository.dart';
import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDetailsProvider = AsyncNotifierProvider.autoDispose
    .family<UserDetailsNotifier, User, int>(UserDetailsNotifier.new);

class UserDetailsNotifier extends AsyncNotifier<User> {
  UserDetailsNotifier(this.id);

  final int id;

  @override
  Future<User> build() {
    return ref.watch(userListRepositoryProvider).fetchUser(id);
  }

  Future<void> retry() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(userListRepositoryProvider).fetchUser(id),
    );
  }
}
