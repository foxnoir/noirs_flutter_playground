import 'package:advanced_concepts/features/user_details/presentation/providers/user_details_provider.dart';
import 'package:advanced_concepts/features/user_list/data/repositories/in_memory_user_list_repository.dart';
import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../user_list/fake_user_list_repository.dart';

void main() {
  const ada = User(
    id: 1,
    nickname: 'Ada',
    email: 'ada@example.com',
    age: 36,
    imageUrl: '',
  );

  test('loads the user by id', () async {
    final container = ProviderContainer.test(
      overrides: [
        userListRepositoryProvider.overrideWithValue(
          const FakeUserListRepository(users: [ada]),
        ),
      ],
    );
    addTearDown(container.dispose);

    final sub = container.listen(userDetailsProvider(1), (_, _) {});
    addTearDown(sub.close);

    await container.pump();

    expect(sub.read().value, ada);
  });
}
