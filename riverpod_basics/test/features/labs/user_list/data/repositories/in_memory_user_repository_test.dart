import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/user_list/data/repositories/in_memory_user_repository.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';

void main() {
  test('fetchUsers maps JSON models to domain users', () async {
    const repository = InMemoryUserRepository(delay: Duration.zero);

    final users = await repository.fetchUsers();

    expect(users, [
      const User(
        id: 10,
        username: 'Grace',
        age: 85,
        email: 'grace@example.com',
      ),
      const User(id: 11, username: 'Alan', age: 41, email: 'alan@example.com'),
    ]);
  });
}
