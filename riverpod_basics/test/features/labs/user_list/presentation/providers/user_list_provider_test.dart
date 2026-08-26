import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/user_list/data/repositories/in_memory_user_repository.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_provider.dart';

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

  test('fetchUsers loads entities from the repository', () async {
    final container = containerWith(const FakeUserRepository(users: [grace]));

    await container.read(userListProvider.notifier).fetchUsers();

    final state = container.read(userListProvider);
    expect(state.users, [grace]);
    expect(state.isLoading, isFalse);
    expect(state.error, isNull);
  });

  test('fetchUsers sets error when the repository throws', () async {
    final container = containerWith(
      const FakeUserRepository(error: NetworkFailure()),
    );

    await container.read(userListProvider.notifier).fetchUsers();

    final state = container.read(userListProvider);
    expect(state.users, isEmpty);
    expect(state.isLoading, isFalse);
    expect(state.error, const NetworkFailure());
  });

  test('ensureLoaded skips fetch when users are already loaded', () async {
    var fetchCount = 0;
    final container = ProviderContainer.test(
      overrides: [
        userRepositoryProvider.overrideWithValue(
          _CountingUserRepository(users: [grace], onFetch: () => fetchCount++),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(userListProvider.notifier).ensureLoaded();
    await container.read(userListProvider.notifier).ensureLoaded();

    expect(fetchCount, 1);
    expect(container.read(userListProvider).users, [grace]);
  });

  test('addUser appends a user', () {
    final container = containerWith(const FakeUserRepository());

    expect(
      container.read(userListProvider.notifier).addUser(ada),
      AddUserResult.added,
    );
    expect(container.read(userListProvider).users, [ada]);
  });

  test('addUser with a duplicate id returns duplicateId', () {
    final container = containerWith(const FakeUserRepository());

    container.read(userListProvider.notifier).addUser(ada);

    expect(
      container
          .read(userListProvider.notifier)
          .addUser(ada.copyWith(username: 'Other')),
      AddUserResult.duplicateId,
    );
    expect(container.read(userListProvider).users, [ada]);
  });

  test('addUser with a duplicate email returns duplicateEmail', () {
    final container = containerWith(const FakeUserRepository());

    container.read(userListProvider.notifier).addUser(ada);

    expect(
      container
          .read(userListProvider.notifier)
          .addUser(ada.copyWith(id: 2, username: 'Other')),
      AddUserResult.duplicateEmail,
    );
    expect(container.read(userListProvider).users, [ada]);
  });
}

class _CountingUserRepository extends FakeUserRepository {
  _CountingUserRepository({required super.users, required this.onFetch});

  final void Function() onFetch;

  @override
  Future<List<User>> fetchUsers() {
    onFetch();
    return super.fetchUsers();
  }
}
