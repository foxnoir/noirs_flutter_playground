import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_info_text.dart';
import 'package:flutter/material.dart';

class ListsLabInfo extends StatelessWidget {
  const ListsLabInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ListsLabRuleRow(
          when: l10n.listsOneAxis,
          then: l10n.listsOneAxisCalls,
          hint: l10n.listsOneAxisHint,
        ),
        const SizedBox(height: 12),
        _ListsLabRuleRow(
          when: l10n.listsRow,
          then: l10n.listsRowCalls,
          hint: l10n.listsRowHint,
        ),
        const SizedBox(height: 12),
        _ListsLabRuleRow(
          when: l10n.listsGrid,
          then: l10n.listsGridCalls,
          hint: l10n.listsGridHint,
        ),
        const SizedBox(height: 12),
        _ListsLabRuleRow(
          when: l10n.listsSliver,
          then: l10n.listsSliverCalls,
          hint: l10n.listsSliverHint,
        ),
        const SizedBox(height: 12),
        _ListsLabRuleRow(
          when: l10n.listsEagerWhen,
          then: l10n.listsEagerCalls,
          hint: l10n.listsEagerHint,
        ),
        const SizedBox(height: 16),
        LabInfoText(l10n.listsContext, textAlign: TextAlign.start),
      ],
    );
  }
}

class _ListsLabRuleRow extends StatelessWidget {
  const _ListsLabRuleRow({
    required this.when,
    required this.then,
    required this.hint,
  });

  final String when;
  final String then;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final teal = textTheme.titleLarge?.color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                when,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 16, color: teal),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                then,
                style: textTheme.bodyMedium?.copyWith(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  color: teal,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(hint, style: textTheme.bodySmall),
      ],
    );
  }
}
