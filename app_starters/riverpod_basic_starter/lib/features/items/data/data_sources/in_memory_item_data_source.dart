import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basic_starter/core/errors/app_exception.dart';
import 'package:riverpod_basic_starter/features/items/data/models/item_model.dart';

abstract interface class ItemDataSource {
  Future<List<ItemModel>> fetchItems();

  Future<ItemModel> fetchItem(int id);
}

final itemDataSourceProvider = Provider<ItemDataSource>((ref) {
  return const InMemoryItemDataSource();
});

/// Fake GET. Throws AppException, never AppFailure.
class InMemoryItemDataSource implements ItemDataSource {
  const InMemoryItemDataSource({
    this.delay = const Duration(milliseconds: 300),
  });

  final Duration delay;

  static const seedJson = [
    {'id': 1, 'title': 'Alpha', 'subtitle': 'First sample item'},
    {'id': 2, 'title': 'Beta', 'subtitle': 'Second sample item'},
  ];

  @override
  Future<List<ItemModel>> fetchItems() async {
    try {
      if (delay > Duration.zero) {
        await Future<void>.delayed(delay);
      }
      return [
        for (final json in seedJson)
          ItemModel.fromJson(Map<String, dynamic>.from(json)),
      ];
    } on AppException {
      rethrow;
    } catch (_) {
      // Unexpected (parse, etc.) → AppException. Repo only maps AppException.
      throw const NetworkException();
    }
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    try {
      final items = await fetchItems();
      for (final item in items) {
        if (item.id == id) return item;
      }
      throw const NotFoundException();
    } on AppException {
      rethrow;
    } catch (_) {
      // Unexpected (parse, etc.) → AppException. Repo only maps AppException.
      throw const NetworkException();
    }
  }
}
