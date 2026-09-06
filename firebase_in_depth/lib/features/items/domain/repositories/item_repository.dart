import 'package:firebase_in_depth/features/items/domain/entities/item.dart';

/// Throws AppFailure when the data source failed.
abstract interface class ItemRepository {
  Future<List<Item>> fetchItems();

  Future<Item> fetchItem(int id);
}
