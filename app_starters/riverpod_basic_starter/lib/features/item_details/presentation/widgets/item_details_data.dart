import 'package:flutter/material.dart';
import 'package:riverpod_basic_starter/features/items/domain/entities/item.dart';

class ItemDetailsData extends StatelessWidget {
  const ItemDetailsData({required this.item, super.key});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Text(item.subtitle, style: Theme.of(context).textTheme.bodyLarge);
  }
}
