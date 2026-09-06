import 'package:flutter/material.dart';
import 'package:riverpod_basic_starter/features/items/domain/entities/item.dart';

class ItemDetailsMetadata extends StatelessWidget {
  const ItemDetailsMetadata({required this.item, super.key});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Text(item.title, style: Theme.of(context).textTheme.titleLarge);
  }
}
