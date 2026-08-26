import 'package:flutter/material.dart';

/// The live ping. Purple like the Listen Manual watch card.
class RefreshInfoCard extends StatelessWidget {
  const RefreshInfoCard({
    required this.label,
    required this.body,
    required this.background,
    required this.foreground,
    required this.isActive,
    super.key,
  });

  final String label;
  final String body;
  final Color background;
  final Color foreground;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Opacity(
      opacity: isActive ? 1 : 0.55,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: foreground.withValues(alpha: isActive ? 0.8 : 0.25),
            width: isActive ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.labelLarge?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: textTheme.bodyMedium?.copyWith(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
