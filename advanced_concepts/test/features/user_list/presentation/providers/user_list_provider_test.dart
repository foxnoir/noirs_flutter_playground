import 'package:advanced_concepts/core/errors/app_failure.dart';
import 'package:advanced_concepts/features/user_list/data/repositories/in_memory_user_list_repository.dart';
import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';
import 'package:advanced_concepts/features/user_list/presentation/providers/user_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fake_user_list_repository.dart';

void main() {
  const ada = User(
    id: 1,
    nickname: 'Ada',
    email: 'ada@example.com',
    age: 36,
    imageUrl: '',
  );

  ProviderContainer containerWith(FakeUserListRepository repository) {
    final container = ProviderContainer.test(
      overrides: [userListRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('loads users from the repository', () async {
    final container = containerWith(const FakeUserListRepository(users: [ada]));
    final sub = container.listen(userListProvider, (_, _) {});
    addTearDown(sub.close);

    await container.pump();

    expect(sub.read().value, [ada]);
  });

  test('stores NetworkFailure when the repository throws', () async {
    final container = containerWith(
      const FakeUserListRepository(error: NetworkFailure()),
    );
    final sub = container.listen(userListProvider, (_, _) {});
    addTearDown(sub.close);

    await container.pump();

    expect(sub.read().error, const NetworkFailure());
  });
}
