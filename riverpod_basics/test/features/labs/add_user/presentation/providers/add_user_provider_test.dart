import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/add_user/data/repositories/in_memory_user_repository.dart';
import 'package:riverpod_basics/features/labs/add_user/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/providers/add_user_provider.dart';

import '../../fake_user_repository.dart';

void main() {
  const ada = User(id: 1, username: 'Ada', age: 36, email: 'ada@example.com');
  const grace = User(
    id: 10,
    username: 'Grace',
    age: 85,
    email: 'grace@example.com',
  );

  ProviderContainer containerWith(FakeUserRepository repository) {
    final container = ProviderContainer.test(
      overrides: [userRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('addUser appends a user and sets isAdded', () {
    final container = containerWith(const FakeUserRepository());

    container.read(addUserProvider.notifier).addUser(ada);

    final state = container.read(addUserProvider);
    expect(state.users, [ada]);
    expect(state.isAdded, isTrue);
    expect(state.error, isNull);
  });

  test('addUser with a duplicate id sets error', () {
    final container = containerWith(const FakeUserRepository());

    container.read(addUserProvider.notifier).addUser(ada);
    container.read(addUserProvider.notifier).acknowledgeAdded();
    container
        .read(addUserProvider.notifier)
        .addUser(ada.copyWith(username: 'Other'));

    final state = container.read(addUserProvider);
    expect(state.users, [ada]);
    expect(state.isAdded, isFalse);
    expect(state.error, duplicateUserIdError);
  });

  test('fetchUsers loads entities from the repository', () async {
    final container = containerWith(const FakeUserRepository(users: [grace]));

    await container.read(addUserProvider.notifier).fetchUsers();

    final state = container.read(addUserProvider);
    expect(state.users, [grace]);
    expect(state.isLoading, isFalse);
    expect(state.error, isNull);
  });

  test('fetchUsers sets error when the repository throws', () async {
    final container = containerWith(
      FakeUserRepository(error: Exception('offline')),
    );

    await container.read(addUserProvider.notifier).fetchUsers();

    final state = container.read(addUserProvider);
    expect(state.users, isEmpty);
    expect(state.isLoading, isFalse);
    expect(state.error, fetchUsersError);
  });
}
