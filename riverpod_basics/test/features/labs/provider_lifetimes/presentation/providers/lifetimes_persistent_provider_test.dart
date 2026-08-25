import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/providers/add_user_provider.dart';

void main() {
  test('addUserProvider keeps state when unlistened', () async {
    final container = ProviderContainer.test();
    addTearDown(container.dispose);

    final sub = container.listen(addUserProvider, (_, _) {});

    expect(container.read(addUserProvider), '-');
    container.read(addUserProvider.notifier).user = 'Ada';
    expect(container.read(addUserProvider), 'Ada');

    sub.close();
    await container.pump();

    expect(container.exists(addUserProvider), isTrue);
    expect(container.read(addUserProvider), 'Ada');
  });
}
