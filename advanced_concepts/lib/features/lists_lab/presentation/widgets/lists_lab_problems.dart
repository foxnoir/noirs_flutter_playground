import 'package:advanced_concepts/features/lists_lab/presentation/widgets/lists_lab_cell.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/lab_compare_frame.dart';
import 'package:advanced_concepts/shared_widgets/lab_error_stripes.dart';
import 'package:flutter/material.dart';

class ListsLabProblems extends StatelessWidget {
  const ListsLabProblems({super.key});

  static const miniCount = 24;
  static const _miniHeight = 144.0;
  static const _itemExtent = 48.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.listsProblemEagerTitle,
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 4),
        Text(l10n.listsProblemEagerCaption, style: textTheme.bodySmall),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _CountedMiniList(
                label: l10n.listsProblemEagerLabel,
                eager: true,
                count: miniCount,
                height: _miniHeight,
                itemExtent: _itemExtent,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _CountedMiniList(
                label: l10n.listsProblemLazyLabel,
                eager: false,
                count: miniCount,
                height: _miniHeight,
                itemExtent: _itemExtent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          l10n.listsProblemUnboundedTitle,
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 4),
        Text(l10n.listsProblemUnboundedCaption, style: textTheme.bodySmall),
        const SizedBox(height: 8),
        LabCompareFrame(
          ok: false,
          title: l10n.listsProblemUnboundedBadTitle,
          hint: l10n.listsProblemUnboundedBadHint,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _UnboundedHeader(label: l10n.listsLayerHeader),
              LabErrorStripes(
                key: const Key('lists-lab-unbounded-wrong'),
                message: l10n.listsStripeUnbounded,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        LabCompareFrame(
          ok: true,
          title: l10n.listsProblemUnboundedGoodTitle,
          hint: l10n.listsProblemUnboundedGoodHint,
          child: SizedBox(
            key: const Key('lists-lab-unbounded-right'),
            height: 168,
            child: Column(
              children: [
                _UnboundedHeader(label: l10n.listsLayerHeader),
                Expanded(
                  child: ListView.builder(
                    itemExtent: 36,
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      final scheme = Theme.of(context).colorScheme;
                      final colors = [
                        scheme.primaryContainer,
                        scheme.secondaryContainer,
                        scheme.tertiary,
                      ];
                      return ColoredBox(
                        color: colors[index % colors.length],
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          l10n.listsProblemShrinkTitle,
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 4),
        Text(l10n.listsProblemShrinkBody, style: textTheme.bodySmall),
      ],
    );
  }
}

class _CountedMiniList extends StatefulWidget {
  const _CountedMiniList({
    required this.label,
    required this.eager,
    required this.count,
    required this.height,
    required this.itemExtent,
  });

  final String label;
  final bool eager;
  final int count;
  final double height;
  final double itemExtent;

  @override
  State<_CountedMiniList> createState() => _CountedMiniListState();
}

class _CountedMiniListState extends State<_CountedMiniList> {
  final _cells = <int>{};
  var _builds = 0;

  void _onBuilt(int index) {
    if (!mounted) return;
    setState(() {
      _cells.add(index);
      _builds++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.label,
          style: textTheme.labelMedium?.copyWith(fontFamily: 'monospace'),
        ),
        const SizedBox(height: 4),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: widget.height,
              child: widget.eager
                  ? ListView(
                      children: [
                        for (var i = 0; i < widget.count; i++)
                          SizedBox(
                            height: widget.itemExtent,
                            child: ListsLabCell(index: i, onBuilt: _onBuilt),
                          ),
                      ],
                    )
                  : ListView.builder(
                      itemExtent: widget.itemExtent,
                      itemCount: widget.count,
                      itemBuilder: (context, index) =>
                          ListsLabCell(index: index, onBuilt: _onBuilt),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${l10n.listsCells} ${_cells.length} / ${widget.count}'
          '  ·  ${l10n.listsBuilds} $_builds',
          style: textTheme.labelSmall,
        ),
      ],
    );
  }
}

class _UnboundedHeader extends StatelessWidget {
  const _UnboundedHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: scheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
