import 'package:riverpod_basic_starter/core/errors/app_failure.dart';
import 'package:riverpod_basic_starter/features/items/domain/entities/item.dart';
import 'package:riverpod_basic_starter/features/items/domain/repositories/item_repository.dart';

class FakeItemRepository implements ItemRepository {
  const FakeItemRepository({this.items = const [], this.error});

  final List<Item> items;
  final AppFailure? error;

  @override
  Future<List<Item>> fetchItems() async {
    final thrown = error;
    if (thrown != null) {
      throw thrown;
    }
    return items;
  }

  @override
  Future<Item> fetchItem(int id) async {
    final thrown = error;
    if (thrown != null) {
      throw thrown;
    }
    for (final item in items) {
      if (item.id == id) return item;
    }
    throw const NotFoundFailure();
  }
}
