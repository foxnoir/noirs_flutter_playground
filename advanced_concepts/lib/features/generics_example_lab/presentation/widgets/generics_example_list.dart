import 'package:advanced_concepts/shared_widgets/apis/api_lab_divider.dart';
import 'package:flutter/material.dart';

class GenericsExampleList<T> extends StatelessWidget {
  const GenericsExampleList({
    required this.items,
    required this.itemBuilder,
    super.key,
  });

  final List<T> items;
  final Widget Function(T item) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, _) => const ApiLabDivider(),
      itemBuilder: (context, index) => itemBuilder(items[index]),
    );
  }
}
