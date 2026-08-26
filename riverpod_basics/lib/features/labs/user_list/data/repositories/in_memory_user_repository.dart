import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/user_list/data/models/user_model.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/repositories/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  // This function is the create: Riverpod calls it once and stores the
  // result. The type is the interface; the returned object is the impl.
  return const InMemoryUserRepository();
});

class InMemoryUserRepository implements UserRepository {
  const InMemoryUserRepository({
    this.delay = const Duration(milliseconds: 300),
  });

  final Duration delay;

  static const seedJson = [
    {'id': 10, 'username': 'Grace', 'age': 85, 'email': 'grace@example.com'},
    {'id': 11, 'username': 'Alan', 'age': 41, 'email': 'alan@example.com'},
  ];

  @override
  Future<List<User>> fetchUsers() async {
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }

    return [
      for (final json in seedJson)
        UserModel.fromJson(Map<String, dynamic>.from(json)).toEntity(),
    ];
  }
}
