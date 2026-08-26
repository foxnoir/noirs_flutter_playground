import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basic_starter/core/errors/app_failure.dart';
import 'package:riverpod_basic_starter/features/items/data/repositories/in_memory_item_repository.dart';
import 'package:riverpod_basic_starter/features/items/domain/entities/item.dart';
import 'package:riverpod_basic_starter/features/items/presentation/providers/item_provider.dart';

import '../../fake_item_repository.dart';

void main() {
  const alpha = Item(id: 1, title: 'Alpha', subtitle: 'First sample item');

  ProviderContainer testContainer({
    FakeItemRepository repository = const FakeItemRepository(items: [alpha]),
  }) {
    final container = ProviderContainer.test(
      overrides: [itemRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('loads the item for that id', () async {
    final container = testContainer();
    final sub = container.listen(itemProvider(1), (_, __) {});
    addTearDown(sub.close);

    await container.pump();

    expect(sub.read().value, alpha);
  });

  test('missing id is AsyncError with NotFoundFailure', () async {
    final container = testContainer();
    final sub = container.listen(itemProvider(99), (_, __) {});
    addTearDown(sub.close);

    await container.pump();

    expect(sub.read().error, isA<NotFoundFailure>());
  });
}
