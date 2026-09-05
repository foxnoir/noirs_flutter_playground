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
      title: _LandingListTileLabel(label: label, caption: caption),
      trailing: Icon(Icons.chevron_right, color: titleStyle?.color),
      onTap: onTap,
    );
  }
}

class _LandingListTileLabel extends StatelessWidget {
  const _LandingListTileLabel({required this.label, this.caption});

  final String label;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final caption = this.caption;
    if (caption == null) {
      return Text(label, style: titleStyle);
    }

    final captionStyle = Theme.of(context).textTheme.bodySmall
        ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(label, style: titleStyle),
        Text(' ($caption)', style: captionStyle),
      ],
    );
  }
}
