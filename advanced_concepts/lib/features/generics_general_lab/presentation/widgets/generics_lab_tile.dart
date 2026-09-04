import 'package:flutter/material.dart';

/// One ListTile. titleOf / subtitleOf are functions you pass, not field names.
class GenericsLabTile<T> extends StatelessWidget {
  const GenericsLabTile({
    required this.item,
    required this.titleOf,
    required this.subtitleOf,
    required this.leading,
    required this.selected,
    required this.onTap,
    this.tileKey,
    super.key,
  });

  final T item;
  final String Function(T item) titleOf;
  final String Function(T item) subtitleOf;
  final Widget leading;
  final bool selected;
  final VoidCallback onTap;
  final Key? tileKey;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: selected
          ? scheme.secondaryContainer
          : scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(8),
      child: ListTile(
        key: tileKey,
        minLeadingWidth: 56,
        minVerticalPadding: 8,
        leading: leading,
        title: Text(titleOf(item)),
        subtitle: Text(subtitleOf(item)),
        selected: selected,
        onTap: onTap,
      ),
    );
  }
}
