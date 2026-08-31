import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class NavStackPreview extends StatelessWidget {
  const NavStackPreview({required this.frames, this.footer, super.key});

  /// Top of the navigation stack first (the visible route).
  final List<String> frames;
  final String? footer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.navStackTitle, style: textTheme.titleSmall),
        const SizedBox(height: 8),
        for (var i = 0; i < frames.length; i++) ...[
          if (i > 0) const SizedBox(height: 6),
          _NavStackFrame(label: frames[i], isCurrent: i == 0),
        ],
        if (footer != null) ...[
          const SizedBox(height: 8),
          Text(footer!, style: textTheme.bodySmall),
        ],
      ],
    );
  }
}

class _NavStackFrame extends StatelessWidget {
  const _NavStackFrame({required this.label, required this.isCurrent});

  final String label;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isCurrent
            ? scheme.primaryContainer
            : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (isCurrent)
              Text(
                l10n.stackYouAreHere,
                style: textTheme.labelSmall?.copyWith(
                  color: scheme.onPrimaryContainer,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
