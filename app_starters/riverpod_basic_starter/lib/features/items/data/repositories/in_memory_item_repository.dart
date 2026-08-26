import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basic_starter/core/errors/app_exception.dart';
import 'package:riverpod_basic_starter/core/errors/app_failure.dart';
import 'package:riverpod_basic_starter/features/items/data/data_sources/in_memory_item_data_source.dart';
import 'package:riverpod_basic_starter/features/items/domain/entities/item.dart';
import 'package:riverpod_basic_starter/features/items/domain/repositories/item_repository.dart';

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  return InMemoryItemRepository(ref.watch(itemDataSourceProvider));
});

/// Maps models → entities and AppException → AppFailure.
class InMemoryItemRepository implements ItemRepository {
  const InMemoryItemRepository(this._dataSource);

  final ItemDataSource _dataSource;

  @override
  Future<List<Item>> fetchItems() async {
    try {
      final models = await _dataSource.fetchItems();
      return [for (final model in models) model.toEntity()];
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  @override
  Future<Item> fetchItem(int id) async {
    try {
      final model = await _dataSource.fetchItem(id);
      return model.toEntity();
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }
}
