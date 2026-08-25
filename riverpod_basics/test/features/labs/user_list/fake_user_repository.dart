import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/repositories/user_repository.dart';

class FakeUserRepository implements UserRepository {
  const FakeUserRepository({this.users = const [], this.error});

  final List<User> users;
  final Exception? error;

  @override
  Future<List<User>> fetchUsers() async {
    final thrown = error;
    if (thrown != null) {
      throw thrown;
    }
    return users;
  }
}
