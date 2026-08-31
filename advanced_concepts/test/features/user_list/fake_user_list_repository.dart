import 'package:advanced_concepts/core/errors/app_failure.dart';
import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';
import 'package:advanced_concepts/features/user_list/domain/repositories/user_list_repository.dart';

class FakeUserListRepository implements UserListRepository {
  const FakeUserListRepository({this.users = const [], this.error});

  final List<User> users;
  final AppFailure? error;

  @override
  Future<List<User>> fetchUsers() async {
    final thrown = error;
    if (thrown != null) {
      throw thrown;
    }
    return users;
  }

  @override
  Future<User> fetchUser(int id) async {
    final thrown = error;
    if (thrown != null) {
      throw thrown;
    }
    for (final user in users) {
      if (user.id == id) return user;
    }
    throw const NotFoundFailure();
  }
}
