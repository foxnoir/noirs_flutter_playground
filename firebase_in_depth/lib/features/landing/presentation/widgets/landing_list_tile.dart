import 'package:flutter/material.dart';

class LandingListTile extends StatelessWidget {
  const LandingListTile({
    required this.label,
    required this.onTap,
    this.caption,
    super.key,
  });

  final String label;
  final String? caption;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return ListTile(
      title: caption == null
          ? Text(label, style: titleStyle)
          : Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(label, style: titleStyle),
                Text(
                  ' ($caption)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
      trailing: Icon(Icons.chevron_right, color: titleStyle?.color),
      onTap: onTap,
    );
  }
}
