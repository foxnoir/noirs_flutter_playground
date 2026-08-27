import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/user_list/data/repositories/in_memory_user_repository.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_provider.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/providers/user_search_family_provider.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/providers/user_search_provider.dart';

import '../../../user_list/fake_user_repository.dart';

void main() {
  const grace = User(
    id: 10,
    username: 'Grace',
    age: 85,
    email: 'grace@example.com',
  );
  const alan = User(
    id: 11,
    username: 'Alan',
    age: 41,
    email: 'alan@example.com',
  );

  ProviderContainer containerWith({
    required FakeUserRepository repository,
    Duration delay = Duration.zero,
  }) {
    final container = ProviderContainer.test(
      overrides: [
        userRepositoryProvider.overrideWithValue(repository),
        userSearchDelayProvider.overrideWithValue(delay),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('loads matches for that query', () async {
    final container = containerWith(
      repository: const FakeUserRepository(users: [grace, alan]),
    );
    await container.read(userListProvider.notifier).fetchUsers();
    container.listen(userSearchFamilyProvider('ala'), (_, _) {});

    final users = await container.read(userSearchFamilyProvider('ala').future);

    expect(users, [alan]);
  });

  test('each query is its own mailbox', () async {
    final container = containerWith(
      repository: const FakeUserRepository(users: [grace, alan]),
    );
    await container.read(userListProvider.notifier).fetchUsers();
    container
      ..listen(userSearchFamilyProvider('10'), (_, _) {})
      ..listen(userSearchFamilyProvider('ala'), (_, _) {});

    expect(
      (await container.read(userSearchFamilyProvider('10').future)).single.id,
      10,
    );
    expect(
      (await container.read(userSearchFamilyProvider('ala').future)).single.id,
      11,
    );
  });

  test('no match is an empty list, not a failure', () async {
    final container = containerWith(
      repository: const FakeUserRepository(users: [grace, alan]),
    );
    await container.read(userListProvider.notifier).fetchUsers();
    container.listen(userSearchFamilyProvider('zzz'), (_, _) {});

    final users = await container.read(userSearchFamilyProvider('zzz').future);

    expect(users, isEmpty);
  });
}
