import 'package:riverpod_basic_starter/core/errors/app_exception.dart';
import 'package:riverpod_basic_starter/features/items/data/data_sources/in_memory_item_data_source.dart';
import 'package:riverpod_basic_starter/features/items/data/models/item_model.dart';

class FakeItemDataSource implements ItemDataSource {
  const FakeItemDataSource({this.models = const [], this.error});

  final List<ItemModel> models;
  final Exception? error;

  @override
  Future<List<ItemModel>> fetchItems() async {
    final thrown = error;
    if (thrown != null) {
      throw thrown;
    }
    return models;
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final thrown = error;
    if (thrown != null) {
      throw thrown;
    }
    for (final model in models) {
      if (model.id == id) return model;
    }
    throw const NotFoundException();
  }
}
