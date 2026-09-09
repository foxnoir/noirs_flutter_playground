import 'package:flutter/material.dart';

/// Compact primary action. Width follows the label, not the parent.
class GradientButton extends StatelessWidget {
  const GradientButton({required this.label, this.onPressed, super.key});

  final String label;
  final VoidCallback? onPressed;

  static const _radius = BorderRadius.all(Radius.circular(12));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Align(
      widthFactor: 1,
      heightFactor: 1,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [scheme.primaryContainer, scheme.primary],
            ),
            borderRadius: _radius,
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: _radius,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: scheme.surface,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
