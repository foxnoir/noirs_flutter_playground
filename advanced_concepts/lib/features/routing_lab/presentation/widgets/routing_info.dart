import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_info_text.dart';
import 'package:flutter/material.dart';

class RoutingInfo extends StatelessWidget {
  const RoutingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RoutingRuleRow(
          when: l10n.routingNeedBack,
          then: l10n.routingNeedBackCalls,
          hint: l10n.routingNeedBackHint,
        ),
        const SizedBox(height: 12),
        RoutingRuleRow(
          when: l10n.routingNoReturn,
          then: l10n.routingNoReturnCalls,
          hint: l10n.routingNoReturnHint,
        ),
        const SizedBox(height: 12),
        RoutingRuleRow(
          when: l10n.routingPopWhen,
          then: l10n.routingPopCalls,
          hint: l10n.routingPopHint,
        ),
        const SizedBox(height: 12),
        RoutingRuleRow(
          when: l10n.routingReplaceWhen,
          then: l10n.routingReplaceCalls,
          hint: l10n.routingReplaceHint,
        ),
        const SizedBox(height: 12),
        RoutingRuleRow(
          when: l10n.routingNamedWhen,
          then: l10n.routingNamedCalls,
          hint: l10n.routingNamedHint,
        ),
        const SizedBox(height: 16),
        LabInfoText(l10n.routingContext, textAlign: TextAlign.start),
      ],
    );
  }
}

class RoutingRuleRow extends StatelessWidget {
  const RoutingRuleRow({
    required this.when,
    required this.then,
    required this.hint,
    super.key,
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
            Text(
              when,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
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
