import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:advanced_concepts/shared_widgets/lab_compare_frame.dart';
import 'package:flutter/material.dart';

class LayoutLabFlex extends StatelessWidget {
  const LayoutLabFlex({super.key});

  static const endWidth = 64.0;
  static const rowHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.layoutFlexTitle, style: textTheme.titleSmall),
        const SizedBox(height: 8),
        LabCompareFrame(
          ok: true,
          title: l10n.layoutFlexFlexibleLabel,
          hint: l10n.layoutFlexFlexibleHint,
          child: const _LayoutLabFlexRow(
            fillKey: Key('layout-lab-flexible-fill'),
            tight: false,
          ),
        ),
        const SizedBox(height: 4),
        CodeSnippet(l10n.layoutFlexCallFlexible),
        const SizedBox(height: 12),
        LabCompareFrame(
          ok: true,
          title: l10n.layoutFlexExpandedLabel,
          hint: l10n.layoutFlexExpandedHint,
          child: const _LayoutLabFlexRow(
            fillKey: Key('layout-lab-expanded-fill'),
            tight: true,
          ),
        ),
        const SizedBox(height: 4),
        CodeSnippet(l10n.layoutFlexCallExpanded),
      ],
    );
  }
}

class _LayoutLabFlexRow extends StatelessWidget {
  const _LayoutLabFlexRow({required this.fillKey, required this.tight});

  final Key fillKey;
  final bool tight;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final hi = ColoredBox(
      key: fillKey,
      color: scheme.secondaryContainer,
      child: SizedBox(
        height: LayoutLabFlex.rowHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            widthFactor: 1,
            child: Text(
              l10n.layoutFlexChild,
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: ColoredBox(
        color: scheme.surfaceContainerHighest,
        child: SizedBox(
          height: LayoutLabFlex.rowHeight,
          child: Row(
            children: [
              _LayoutLabFlexEnd(label: l10n.layoutFlexEnd),
              Expanded(
                child: Stack(
                  children: [
                    if (!tight)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            l10n.layoutFlexLeftover,
                            key: const Key('layout-lab-leftover'),
                            style: textTheme.labelSmall?.copyWith(
                              color: textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: tight ? SizedBox.expand(child: hi) : hi,
                    ),
                  ],
                ),
              ),
              _LayoutLabFlexEnd(label: l10n.layoutFlexEnd),
            ],
          ),
        ),
      ),
    );
  }
}

class _LayoutLabFlexEnd extends StatelessWidget {
  const _LayoutLabFlexEnd({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: LayoutLabFlex.endWidth,
      height: LayoutLabFlex.rowHeight,
      child: ColoredBox(
        color: scheme.primaryContainer,
        child: Center(child: Text(label, style: textTheme.labelLarge)),
      ),
    );
  }
}
