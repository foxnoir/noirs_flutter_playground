import 'package:flutter/material.dart';

class UserSearchPanel extends StatelessWidget {
  const UserSearchPanel({
    required this.label,
    required this.background,
    required this.foreground,
    required this.child,
    super.key,
  });

  final String label;
  final Color background;
  final Color foreground;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                label,
                style: textTheme.labelLarge?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
