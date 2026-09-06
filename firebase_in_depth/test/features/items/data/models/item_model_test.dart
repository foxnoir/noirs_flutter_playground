import 'package:firebase_in_depth/features/items/data/models/item_model.dart';
import 'package:firebase_in_depth/features/items/domain/entities/item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fromJson maps to an entity', () {
    const json = {'id': 1, 'title': 'Alpha', 'subtitle': 'First sample item'};

    expect(
      ItemModel.fromJson(json).toEntity(),
      const Item(id: 1, title: 'Alpha', subtitle: 'First sample item'),
    );
  });
}
