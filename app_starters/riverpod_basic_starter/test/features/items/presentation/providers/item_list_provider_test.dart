import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basic_starter/core/errors/app_failure.dart';
import 'package:riverpod_basic_starter/features/items/data/repositories/in_memory_item_repository.dart';
import 'package:riverpod_basic_starter/features/items/domain/entities/item.dart';
import 'package:riverpod_basic_starter/features/items/presentation/providers/item_list_provider.dart';

import '../../fake_item_repository.dart';

void main() {
  const alpha = Item(id: 1, title: 'Alpha', subtitle: 'First sample item');

  ProviderContainer containerWith(FakeItemRepository repository) {
    final container = ProviderContainer.test(
      overrides: [itemRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('loads items from the repository', () async {
    final container = containerWith(const FakeItemRepository(items: [alpha]));
    final sub = container.listen(itemListProvider, (_, __) {});
    addTearDown(sub.close);

    await container.pump();

    expect(sub.read().value, [alpha]);
  });

  test('stores NetworkFailure when the repository throws', () async {
    final container = containerWith(
      const FakeItemRepository(error: NetworkFailure()),
    );
    final sub = container.listen(itemListProvider, (_, __) {});
    addTearDown(sub.close);

    await container.pump();

    expect(sub.read().error, const NetworkFailure());
  });
}
