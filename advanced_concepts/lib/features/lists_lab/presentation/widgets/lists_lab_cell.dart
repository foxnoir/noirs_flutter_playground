import 'package:flutter/material.dart';

class ListsLabCell extends StatefulWidget {
  const ListsLabCell({required this.index, required this.onBuilt, super.key});

  final int index;
  final ValueChanged<int> onBuilt;

  @override
  State<ListsLabCell> createState() => _ListsLabCellState();
}

class _ListsLabCellState extends State<ListsLabCell> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.onBuilt(widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = [
      scheme.primaryContainer,
      scheme.secondaryContainer,
      scheme.tertiary,
    ];

    return ColoredBox(
      color: colors[widget.index % colors.length],
      child: Center(
        child: Text(
          '${widget.index + 1}',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).textTheme.titleLarge?.color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
