import 'package:flutter/material.dart';
import 'package:riverpod_basic_starter/features/items/domain/entities/item.dart';

class ItemsRow extends StatelessWidget {
  const ItemsRow({required this.item, required this.onTap, super.key});

  final Item item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text(item.subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
