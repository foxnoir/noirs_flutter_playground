import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/providers/add_user_non_persistent_provider.dart';

void main() {
  test('addUserNonPersistentProvider disposes when unlistened', () async {
    final container = ProviderContainer.test();
    addTearDown(container.dispose);

    final sub = container.listen(addUserNonPersistentProvider, (_, _) {});

    expect(container.read(addUserNonPersistentProvider), '-');
    container.read(addUserNonPersistentProvider.notifier).user = 'Ada';
    expect(container.read(addUserNonPersistentProvider), 'Ada');

    sub.close();
    await container.pump();

    expect(container.exists(addUserNonPersistentProvider), isFalse);

    final next = container.listen(addUserNonPersistentProvider, (_, _) {});
    addTearDown(next.close);

    expect(container.read(addUserNonPersistentProvider), '-');
  });
}
