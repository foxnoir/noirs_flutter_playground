import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basic_starter/features/items/data/models/item_model.dart';
import 'package:riverpod_basic_starter/features/items/domain/entities/item.dart';

void main() {
  test('fromJson maps to an entity', () {
    const json = {'id': 1, 'title': 'Alpha', 'subtitle': 'First sample item'};

    expect(
      ItemModel.fromJson(json).toEntity(),
      const Item(id: 1, title: 'Alpha', subtitle: 'First sample item'),
    );
  });
}
