import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/user_list/data/repositories/in_memory_user_repository.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_provider.dart';
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
  const users = [grace, alan];

  test('empty or whitespace query matches nobody', () {
    expect(usersMatchingQuery(users, ''), isEmpty);
    expect(usersMatchingQuery(users, '   '), isEmpty);
  });

  test('matches username case-insensitively', () {
    expect(usersMatchingQuery(users, 'grace'), [grace]);
    expect(usersMatchingQuery(users, 'ALA'), [alan]);
  });

  test('matches an exact id', () {
    expect(usersMatchingQuery(users, '10'), [grace]);
    expect(usersMatchingQuery(users, '11'), [alan]);
  });

  test('id match is exact, not a prefix', () {
    expect(usersMatchingQuery(users, '1'), isEmpty);
  });

  test('no match returns empty', () {
    expect(usersMatchingQuery(users, 'zzz'), isEmpty);
  });

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
    container.listen(userSearchProvider, (_, _) {});
    return container;
  }

  test('search returns matches after the fake delay', () async {
    final container = containerWith(
      repository: const FakeUserRepository(users: users),
    );

    await container.read(userListProvider.notifier).fetchUsers();
    await container.read(userSearchProvider.notifier).search('10');

    final state = container.read(userSearchProvider);
    expect(state.isSearching, isFalse);
    expect(state.hasSearched, isTrue);
    expect(state.matches, [grace]);
  });

  test('empty search resets to idle', () async {
    final container = containerWith(
      repository: const FakeUserRepository(users: users),
    );

    await container.read(userListProvider.notifier).fetchUsers();
    await container.read(userSearchProvider.notifier).search('10');
    await container.read(userSearchProvider.notifier).search('   ');

    final state = container.read(userSearchProvider);
    expect(state.hasSearched, isFalse);
    expect(state.matches, isEmpty);
  });
}
