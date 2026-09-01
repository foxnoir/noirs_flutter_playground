import 'package:advanced_concepts/features/lists_lab/presentation/lists_lab_kind.dart';
import 'package:advanced_concepts/features/lists_lab/presentation/widgets/lists_lab_info.dart';
import 'package:advanced_concepts/features/lists_lab/presentation/widgets/lists_lab_preview.dart';
import 'package:advanced_concepts/features/lists_lab/presentation/widgets/lists_lab_problems.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:flutter/material.dart';

class ListsLabScreen extends StatefulWidget {
  const ListsLabScreen({super.key});

  static const itemCount = 48;

  @override
  State<ListsLabScreen> createState() => _ListsLabScreenState();
}

class _ListsLabScreenState extends State<ListsLabScreen> {
  var _kind = ListsLabKind.list;
  final _cells = <int>{};
  var _builds = 0;

  void _select(ListsLabKind kind) {
    setState(() {
      _kind = kind;
      _cells.clear();
      _builds = 0;
    });
  }

  void _onCellBuilt(int index) {
    if (!mounted) return;
    setState(() {
      _cells.add(index);
      _builds++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.lists)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListsLabInfo(),
          const SizedBox(height: 20),
          SegmentedButton<ListsLabKind>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: ListsLabKind.list,
                label: Text(l10n.listsKindList),
              ),
              ButtonSegment(
                value: ListsLabKind.horizontal,
                label: Text(l10n.listsKindHorizontal),
              ),
              ButtonSegment(
                value: ListsLabKind.grid,
                label: Text(l10n.listsKindGrid),
              ),
              ButtonSegment(
                value: ListsLabKind.sliver,
                label: Text(l10n.listsKindSliver),
              ),
            ],
            selected: {_kind},
            onSelectionChanged: (selected) => _select(selected.single),
          ),
          const SizedBox(height: 8),
          ListsLabPreview(
            key: ValueKey(_kind),
            kind: _kind,
            itemCount: ListsLabScreen.itemCount,
            onCellBuilt: _onCellBuilt,
          ),
          const SizedBox(height: 8),
          Text(
            '${l10n.listsCells} ${_cells.length} / ${ListsLabScreen.itemCount}'
            '  ·  ${l10n.listsBuilds} $_builds',
            key: const Key('lists-lab-built'),
            style: textTheme.labelLarge,
          ),
          const SizedBox(height: 4),
          Text(l10n.listsDemoHint, style: textTheme.bodySmall),
          const SizedBox(height: 8),
          CodeSnippet(_call(l10n)),
          const SizedBox(height: 24),
          const ListsLabProblems(),
        ],
      ),
    );
  }

  String _call(AppLocalizations l10n) {
    return switch (_kind) {
      ListsLabKind.list => l10n.listsCallList,
      ListsLabKind.grid => l10n.listsCallGrid,
      ListsLabKind.sliver => l10n.listsCallSliver,
      ListsLabKind.horizontal => l10n.listsCallHorizontal,
    };
  }
}
