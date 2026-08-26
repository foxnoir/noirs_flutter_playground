import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basic_starter/core/errors/app_exception.dart';
import 'package:riverpod_basic_starter/features/items/data/data_sources/in_memory_item_data_source.dart';

void main() {
  test('fetchItems returns JSON models', () async {
    const source = InMemoryItemDataSource(delay: Duration.zero);

    final models = await source.fetchItems();

    expect(models, hasLength(2));
    expect(models.first.title, 'Alpha');
  });

  test('fetchItem throws NotFoundException for a missing id', () async {
    const source = InMemoryItemDataSource(delay: Duration.zero);

    await expectLater(source.fetchItem(99), throwsA(isA<NotFoundException>()));
  });
}
