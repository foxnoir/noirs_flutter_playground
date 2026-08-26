import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basic_starter/features/items/data/repositories/in_memory_item_repository.dart';
import 'package:riverpod_basic_starter/features/items/domain/entities/item.dart';

final itemListProvider = AsyncNotifierProvider<ItemListNotifier, List<Item>>(
  ItemListNotifier.new,
);

class ItemListNotifier extends AsyncNotifier<List<Item>> {
  @override
  Future<List<Item>> build() {
    return ref.watch(itemRepositoryProvider).fetchItems();
  }

  Future<void> retry() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(itemRepositoryProvider).fetchItems(),
    );
  }
}
