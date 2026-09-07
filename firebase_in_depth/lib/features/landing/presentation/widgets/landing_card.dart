import 'package:flutter/material.dart';

class LandingCard extends StatefulWidget {
  const LandingCard({
    required this.title,
    required this.body,
    required this.onTap,
    super.key,
  });

  final String title;
  final String body;
  final VoidCallback onTap;

  @override
  State<LandingCard> createState() => _LandingCardState();
}

class _LandingCardState extends State<LandingCard> {
  var _hovered = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: _hovered ? 0.98 : 0.9),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered ? scheme.primary : scheme.outlineVariant,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title, style: textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                widget.body,
                style: textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
