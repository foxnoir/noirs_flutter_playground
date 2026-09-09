import 'package:flutter/material.dart';

/// Compact action. Default is the primary purple gradient.
class GradientButton extends StatelessWidget {
  const GradientButton({
    required this.label,
    this.onPressed,
    this.startColor,
    this.endColor,
    this.foregroundColor,
    this.compact = false,
    this.expanded = false,
    this.pill = false,
    super.key,
  });

  /// Primary purple gradient. Same as the default constructor.
  const GradientButton.primary({
    required String label,
    VoidCallback? onPressed,
    bool compact = false,
    bool expanded = false,
    bool pill = false,
    Key? key,
  }) : this(
         label: label,
         onPressed: onPressed,
         compact: compact,
         expanded: expanded,
         pill: pill,
         key: key,
       );

  final String label;
  final VoidCallback? onPressed;
  final Color? startColor;
  final Color? endColor;
  final Color? foregroundColor;
  final bool compact;
  final bool expanded;
  final bool pill;

  static const _radius = BorderRadius.all(Radius.circular(12));
  static const _pillRadius = BorderRadius.all(Radius.circular(999));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final start = startColor ?? scheme.primaryContainer;
    final end = endColor ?? scheme.primary;
    final padding = compact
        ? const EdgeInsets.symmetric(horizontal: 12, vertical: 6)
        : const EdgeInsets.symmetric(horizontal: 24, vertical: 10);
    final radius = pill ? _pillRadius : _radius;

    final button = Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [start, end],
          ),
          borderRadius: radius,
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: radius,
          child: Padding(
            padding: padding,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelLarge?.copyWith(
                color: foregroundColor ?? scheme.surface,
              ),
            ),
          ),
        ),
      ),
    );

    if (expanded) {
      return SizedBox(width: double.infinity, child: button);
    }

    return Align(widthFactor: 1, heightFactor: 1, child: button);
  }
}
