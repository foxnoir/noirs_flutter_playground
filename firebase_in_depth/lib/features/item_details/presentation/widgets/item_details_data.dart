import 'package:firebase_in_depth/features/items/domain/entities/item.dart';
import 'package:flutter/material.dart';

class ItemDetailsData extends StatelessWidget {
  const ItemDetailsData({required this.item, super.key});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Text(item.subtitle, style: Theme.of(context).textTheme.bodyLarge);
  }
}
