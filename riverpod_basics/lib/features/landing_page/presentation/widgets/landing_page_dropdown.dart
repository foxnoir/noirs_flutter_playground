import 'package:flutter/material.dart';

class LandingPageDropdownItem {
  const LandingPageDropdownItem({required this.label, this.onTap});

  final String label;
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
            title: Text(item.label),
            trailing: item.onTap == null
                ? null
                : const Icon(Icons.chevron_right),
            onTap: item.onTap,
          ),
      ],
    );
  }
}
