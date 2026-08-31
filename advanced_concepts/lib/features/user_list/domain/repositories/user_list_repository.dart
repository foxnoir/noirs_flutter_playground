import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';

/// Throws AppFailure when the data source failed.
abstract interface class UserListRepository {
  Future<List<User>> fetchUsers();

  Future<User> fetchUser(int id);
}
