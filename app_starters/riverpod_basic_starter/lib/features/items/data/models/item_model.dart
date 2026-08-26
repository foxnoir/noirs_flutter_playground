import 'package:riverpod_basic_starter/features/items/domain/entities/item.dart';

class ItemModel {
  const ItemModel({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] as int,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
    );
  }

  final int id;
  final String title;
  final String subtitle;

  Item toEntity() {
    return Item(id: id, title: title, subtitle: subtitle);
  }
}
