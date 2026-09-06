import 'package:firebase_depth/features/items/data/repositories/in_memory_item_repository.dart';
import 'package:firebase_depth/features/items/domain/entities/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemProvider = AsyncNotifierProvider.autoDispose
    .family<ItemNotifier, Item, int>(ItemNotifier.new);

class ItemNotifier extends AsyncNotifier<Item> {
  ItemNotifier(this.id);

  final int id;

  @override
  Future<Item> build() {
    return ref.watch(itemRepositoryProvider).fetchItem(id);
  }

  Future<void> retry() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(itemRepositoryProvider).fetchItem(id),
    );
  }
}
