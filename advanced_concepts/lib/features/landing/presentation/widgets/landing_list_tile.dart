import 'package:flutter/material.dart';

class LandingListTile extends StatelessWidget {
  const LandingListTile({required this.label, required this.onTap, super.key});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return ListTile(
      title: Text(label, style: titleStyle),
      trailing: Icon(Icons.chevron_right, color: titleStyle?.color),
      onTap: onTap,
    );
  }
}
