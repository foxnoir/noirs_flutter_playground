import 'package:flutter/material.dart';

class RoutingLabNavTile extends StatelessWidget {
  const RoutingLabNavTile({
    required this.call,
    required this.caption,
    required this.onTap,
    super.key,
  });

  final String call;
  final String caption;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        call,
                        style: textTheme.titleSmall?.copyWith(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                          color: textTheme.titleLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(caption, style: textTheme.bodySmall),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: textTheme.titleLarge?.color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
