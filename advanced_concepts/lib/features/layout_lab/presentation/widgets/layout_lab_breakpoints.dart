import 'package:advanced_concepts/core/theme/theme.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:flutter/material.dart';

class LayoutLabBreakpoints extends StatelessWidget {
  const LayoutLabBreakpoints({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final windowWidth = MediaQuery.sizeOf(context).width;
    final windowBreakpoint = AppBreakpoint.fromWidth(windowWidth);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.layoutBreakpointTitle, style: textTheme.titleSmall),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            final parentWidth = constraints.maxWidth;
            final parentBreakpoint = AppBreakpoint.fromWidth(parentWidth);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.layoutBreakpointChip(
                    parentWidth.round(),
                    _layoutBreakpointName(l10n, parentBreakpoint),
                  ),
                  key: const Key('layout-lab-breakpoint-chip'),
                  style: textTheme.labelLarge,
                ),
                Text(
                  l10n.layoutBreakpointWindowChip(
                    windowWidth.round(),
                    _layoutBreakpointName(l10n, windowBreakpoint),
                  ),
                  key: const Key('layout-lab-breakpoint-window-chip'),
                  style: textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                _LayoutLabBreakpointTrack(
                  parentWidth: parentWidth,
                  windowWidth: windowWidth,
                ),
                const SizedBox(height: 8),
                _LayoutLabBreakpointTiles(
                  key: const Key('layout-lab-breakpoint'),
                  compact: parentBreakpoint.isCompact,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        Text(l10n.layoutBreakpointHint, style: textTheme.bodySmall),
        const SizedBox(height: 4),
        CodeSnippet(l10n.layoutBreakpointCall),
      ],
    );
  }
}

class _LayoutLabBreakpointTrack extends StatelessWidget {
  const _LayoutLabBreakpointTrack({
    required this.parentWidth,
    required this.windowWidth,
  });

  final double parentWidth;
  final double windowWidth;

  static const _scale = AppBreakpoint.extraLargeMin;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          key: const Key('layout-lab-breakpoint-track'),
          height: 28,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final trackWidth = constraints.maxWidth;
              return Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 10,
                    child: ColoredBox(
                      color: scheme.surfaceContainerHighest,
                      child: const SizedBox(height: 8, width: double.infinity),
                    ),
                  ),
                  for (final cut in AppBreakpoint.jumps)
                    _tick(
                      x: _x(cut, trackWidth),
                      trackWidth: trackWidth,
                      color: scheme.outline,
                      width: 1,
                    ),
                  _tick(
                    x: _x(windowWidth, trackWidth),
                    trackWidth: trackWidth,
                    color: scheme.tertiary,
                    width: 2,
                  ),
                  _tick(
                    x: _x(parentWidth, trackWidth),
                    trackWidth: trackWidth,
                    color: scheme.secondary,
                    width: 2,
                  ),
                ],
              );
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: AppBreakpoint.mediumMin.toInt(),
              child: Text(
                '${AppBreakpoint.mediumMin.round()}',
                textAlign: TextAlign.end,
                style: textTheme.labelSmall,
              ),
            ),
            Expanded(
              flex: (AppBreakpoint.expandedMin - AppBreakpoint.mediumMin)
                  .toInt(),
              child: Text(
                '${AppBreakpoint.expandedMin.round()}',
                textAlign: TextAlign.end,
                style: textTheme.labelSmall,
              ),
            ),
            Expanded(
              flex: (AppBreakpoint.largeMin - AppBreakpoint.expandedMin)
                  .toInt(),
              child: Text(
                '${AppBreakpoint.largeMin.round()}',
                textAlign: TextAlign.end,
                style: textTheme.labelSmall,
              ),
            ),
            Expanded(
              flex: (AppBreakpoint.extraLargeMin - AppBreakpoint.largeMin)
                  .toInt(),
              child: Text(
                '${AppBreakpoint.extraLargeMin.round()}',
                textAlign: TextAlign.end,
                style: textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static double _x(double width, double trackWidth) {
    return (width / _scale).clamp(0.0, 1.0) * trackWidth;
  }

  static Widget _tick({
    required double x,
    required double trackWidth,
    required Color color,
    required double width,
  }) {
    return Positioned(
      left: (x - width / 2).clamp(0.0, trackWidth - width),
      top: 4,
      bottom: 4,
      child: ColoredBox(
        color: color,
        child: SizedBox(width: width),
      ),
    );
  }
}

class _LayoutLabBreakpointTiles extends StatelessWidget {
  const _LayoutLabBreakpointTiles({required this.compact, super.key});

  static const _tileHeight = 48.0;

  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return const Column(
        children: [
          _LayoutLabBreakpointTile(letter: 'A'),
          SizedBox(height: 4),
          _LayoutLabBreakpointTile(letter: 'B'),
        ],
      );
    }

    return const SizedBox(
      height: _tileHeight,
      child: Row(
        children: [
          Expanded(child: _LayoutLabBreakpointTile(letter: 'A')),
          SizedBox(width: 4),
          Expanded(child: _LayoutLabBreakpointTile(letter: 'B')),
        ],
      ),
    );
  }
}

class _LayoutLabBreakpointTile extends StatelessWidget {
  const _LayoutLabBreakpointTile({required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ColoredBox(
      color: scheme.secondaryContainer,
      child: SizedBox(
        height: _LayoutLabBreakpointTiles._tileHeight,
        child: Center(child: Text(letter, style: textTheme.labelLarge)),
      ),
    );
  }
}

String _layoutBreakpointName(AppLocalizations l10n, AppBreakpoint breakpoint) {
  return switch (breakpoint) {
    AppBreakpoint.compact => l10n.layoutSizeCompact,
    AppBreakpoint.medium => l10n.layoutSizeMedium,
    AppBreakpoint.expanded => l10n.layoutSizeExpanded,
    AppBreakpoint.large => l10n.layoutSizeLarge,
    AppBreakpoint.extraLarge => l10n.layoutSizeExtraLarge,
  };
}
