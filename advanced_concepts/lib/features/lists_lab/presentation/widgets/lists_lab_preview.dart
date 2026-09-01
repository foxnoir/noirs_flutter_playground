import 'package:advanced_concepts/features/lists_lab/presentation/lists_lab_kind.dart';
import 'package:advanced_concepts/features/lists_lab/presentation/widgets/lists_lab_cell.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ListsLabPreview extends StatelessWidget {
  const ListsLabPreview({
    required this.kind,
    required this.itemCount,
    required this.onCellBuilt,
    super.key,
  });

  static const height = 220.0;
  static const itemExtent = 48.0;
  static const horizontalItemExtent = 72.0;

  final ListsLabKind kind;
  final int itemCount;
  final ValueChanged<int> onCellBuilt;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: height,
          child: switch (kind) {
            ListsLabKind.list => ListView.builder(
              itemExtent: itemExtent,
              itemCount: itemCount,
              itemBuilder: (context, index) => _cell(index),
            ),
            ListsLabKind.grid => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: itemExtent,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              padding: const EdgeInsets.all(6),
              itemCount: itemCount,
              itemBuilder: (context, index) => _cell(index),
            ),
            ListsLabKind.sliver => CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _SliverHeader()),
                SliverPadding(
                  padding: const EdgeInsets.all(6),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: itemExtent,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _cell(index),
                      childCount: 6,
                    ),
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: itemExtent,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _cell(index + 6),
                    childCount: itemCount - 6,
                  ),
                ),
              ],
            ),
            ListsLabKind.horizontal => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemExtent: horizontalItemExtent,
              itemCount: itemCount,
              itemBuilder: (context, index) => _cell(index),
            ),
          },
        ),
      ),
    );
  }

  Widget _cell(int index) {
    return ListsLabCell(index: index, onBuilt: onCellBuilt);
  }
}

class _SliverHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: scheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Text(
          l10n.listsSliverHeader,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
