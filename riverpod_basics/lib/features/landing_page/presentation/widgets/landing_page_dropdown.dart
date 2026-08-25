import 'package:flutter/material.dart';

class LandingPageDropdownItem {
  const LandingPageDropdownItem({
    required this.label,
    this.caption,
    this.onTap,
  });

  final String label;
  final String? caption;
  final VoidCallback? onTap;
}

class LandingPageDropdown extends StatelessWidget {
  const LandingPageDropdown({
    required this.title,
    required this.items,
    super.key,
  });

  final String title;
  final List<LandingPageDropdownItem> items;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return ExpansionTile(
      iconColor: titleStyle?.color,
      collapsedIconColor: titleStyle?.color,
      title: Text(title, style: titleStyle),
      children: [
        for (final item in items)
          ListTile(
            title: _LandingPageDropdownItemLabel(item: item),
            trailing: item.onTap == null
                ? null
                : const Icon(Icons.chevron_right),
            onTap: item.onTap,
          ),
      ],
    );
  }
}

class _LandingPageDropdownItemLabel extends StatelessWidget {
  const _LandingPageDropdownItemLabel({required this.item});

  final LandingPageDropdownItem item;

  @override
  Widget build(BuildContext context) {
    final caption = item.caption;
    if (caption == null) {
      return Text(item.label);
    }

    final captionStyle = Theme.of(context).textTheme.bodySmall
        ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(item.label),
        Text(' ($caption)', style: captionStyle),
      ],
    );
  }
}
