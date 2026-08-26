import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basic_starter/core/errors/app_exception.dart';
import 'package:riverpod_basic_starter/core/errors/app_failure.dart';
import 'package:riverpod_basic_starter/features/items/data/data_sources/in_memory_item_data_source.dart';
import 'package:riverpod_basic_starter/features/items/data/models/item_model.dart';
import 'package:riverpod_basic_starter/features/items/data/repositories/in_memory_item_repository.dart';
import 'package:riverpod_basic_starter/features/items/domain/entities/item.dart';

import '../../fake_item_data_source.dart';

void main() {
  const alpha = Item(id: 1, title: 'Alpha', subtitle: 'First sample item');

  test('fetchItems maps models to entities', () async {
    const repository = InMemoryItemRepository(
      InMemoryItemDataSource(delay: Duration.zero),
    );

    final items = await repository.fetchItems();

    expect(items.first, alpha);
    expect(items, hasLength(2));
  });

  test('fetchItems maps a data-source exception to AppFailure', () async {
    const repository = InMemoryItemRepository(
      FakeItemDataSource(error: NetworkException()),
    );

    await expectLater(repository.fetchItems(), throwsA(const NetworkFailure()));
  });

  test('fetchItem maps NotFoundException to NotFoundFailure', () async {
    const repository = InMemoryItemRepository(
      FakeItemDataSource(
        models: [
          ItemModel(id: 1, title: 'Alpha', subtitle: 'First sample item'),
        ],
      ),
    );

    await expectLater(
      repository.fetchItem(99),
      throwsA(const NotFoundFailure()),
    );
  });
}
