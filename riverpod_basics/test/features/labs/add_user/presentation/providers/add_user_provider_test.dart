import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/providers/add_user_provider.dart';
import 'package:riverpod_basics/features/labs/user_list/data/repositories/in_memory_user_repository.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_provider.dart';

import '../../../user_list/fake_user_repository.dart';

void main() {
  const ada = User(id: 1, username: 'Ada', age: 36, email: 'ada@example.com');

  ProviderContainer containerWith(FakeUserRepository repository) {
    final container = ProviderContainer.test(
      overrides: [userRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('addUser appends to the user list and sets isAdded', () {
    final container = containerWith(const FakeUserRepository());

    container.read(addUserProvider.notifier).addUser(ada);

    expect(container.read(userListProvider).users, [ada]);
    expect(container.read(addUserProvider).isAdded, isTrue);
    expect(container.read(addUserProvider).error, isNull);
  });

  test('addUser with a duplicate id sets error', () {
    final container = containerWith(const FakeUserRepository());

    container.read(addUserProvider.notifier).addUser(ada);
    container.read(addUserProvider.notifier).acknowledgeAdded();
    container
        .read(addUserProvider.notifier)
        .addUser(ada.copyWith(username: 'Other'));

    expect(container.read(userListProvider).users, [ada]);
    expect(container.read(addUserProvider).isAdded, isFalse);
    expect(container.read(addUserProvider).error, duplicateUserIdError);
  });

  test('addUser with a duplicate email sets error', () {
    final container = containerWith(const FakeUserRepository());

    container.read(addUserProvider.notifier).addUser(ada);
    container.read(addUserProvider.notifier).acknowledgeAdded();
    container
        .read(addUserProvider.notifier)
        .addUser(ada.copyWith(id: 2, username: 'Other'));

    expect(container.read(userListProvider).users, [ada]);
    expect(container.read(addUserProvider).isAdded, isFalse);
    expect(container.read(addUserProvider).error, duplicateEmailError);
  });
}
