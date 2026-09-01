import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/lab_info_text.dart';
import 'package:flutter/material.dart';

class LayoutLabInfo extends StatelessWidget {
  const LayoutLabInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LayoutLabRuleRow(
          when: l10n.layoutMayShrink,
          then: l10n.layoutMayShrinkCalls,
          hint: l10n.layoutMayShrinkHint,
        ),
        const SizedBox(height: 12),
        _LayoutLabRuleRow(
          when: l10n.layoutMustFill,
          then: l10n.layoutMustFillCalls,
          hint: l10n.layoutMustFillHint,
        ),
        const SizedBox(height: 12),
        _LayoutLabRuleRow(
          when: l10n.layoutPreferredWhen,
          then: l10n.layoutPreferredCalls,
          hint: l10n.layoutPreferredHint,
        ),
        const SizedBox(height: 16),
        LabInfoText(l10n.layoutContext, textAlign: TextAlign.start),
      ],
    );
  }
}

class _LayoutLabRuleRow extends StatelessWidget {
  const _LayoutLabRuleRow({
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
