import 'package:riverpod_basics/features/labs/user_list/data/models/user_model.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';

/// Not imported. Concrete class only — no UserRepository interface.
class HardWiredUserRepository {
  const HardWiredUserRepository();

  Future<List<User>> fetchUsers() async {
    const seedJson = [
      {'id': 10, 'username': 'Grace', 'age': 85, 'email': 'grace@example.com'},
      {'id': 11, 'username': 'Alan', 'age': 41, 'email': 'alan@example.com'},
    ];
    return [
      for (final json in seedJson)
        UserModel.fromJson(Map<String, dynamic>.from(json)).toEntity(),
    ];
  }
}
