import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/codegen/presentation/providers/user_by_id_provider.dart';
import 'package:riverpod_basics/features/labs/user_list/data/repositories/in_memory_user_repository.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';

import '../../../user_list/fake_user_repository.dart';

ProviderContainer testContainer() {
  final container = ProviderContainer.test(
    overrides: [
      userRepositoryProvider.overrideWithValue(
        const FakeUserRepository(
          users: [
            User(
              id: 10,
              username: 'Grace',
              age: 85,
              email: 'grace@example.com',
            ),
            User(id: 11, username: 'Alan', age: 41, email: 'alan@example.com'),
          ],
        ),
      ),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('loads the user for that id', () async {
    final container = testContainer();

    final user = await container.read(userByIdProvider(10).future);
    expect(user.username, 'Grace');
  });

  test('each id is its own mailbox', () async {
    final container = testContainer();

    expect((await container.read(userByIdProvider(10).future)).id, 10);
    expect((await container.read(userByIdProvider(11).future)).id, 11);
  });

  test('reload runs the GET again', () async {
    final container = testContainer();

    await container.read(userByIdProvider(10).future);
    await container.read(userByIdProvider(10).notifier).reload();

    expect(
      (await container.read(userByIdProvider(10).future)).username,
      'Grace',
    );
  });

  test('missing id is AsyncError with NotFoundFailure', () async {
    final container = testContainer();
    final sub = container.listen(userByIdProvider(99), (_, __) {});
    addTearDown(sub.close);

    await container.pump();

    expect(sub.read().error, isA<NotFoundFailure>());
  });
}
