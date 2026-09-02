import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_info_text.dart';
import 'package:flutter/material.dart';

class ApiLabInfo extends StatelessWidget {
  const ApiLabInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ApiLabRuleRow(
          when: l10n.apiCrudWhen,
          then: l10n.apiCrudCalls,
          hint: l10n.apiCrudHint,
        ),
        const SizedBox(height: 12),
        _ApiLabRuleRow(
          when: l10n.apiInterceptorWhen,
          then: l10n.apiInterceptorCalls,
          hint: l10n.apiInterceptorHint,
        ),
        const SizedBox(height: 12),
        _ApiLabRuleRow(
          when: l10n.apiUnifiedWhen,
          then: l10n.apiUnifiedCalls,
          hint: l10n.apiUnifiedHint,
        ),
        const SizedBox(height: 12),
        _ApiLabRuleRow(
          when: l10n.apiTimeoutWhen,
          then: l10n.apiTimeoutCalls,
          hint: l10n.apiTimeoutHint,
        ),
        const SizedBox(height: 12),
        _ApiLabRuleRow(
          when: l10n.apiNetworkWhen,
          then: l10n.apiNetworkCalls,
          hint: l10n.apiNetworkHint,
        ),
        const SizedBox(height: 16),
        LabInfoText(l10n.apiContext, textAlign: TextAlign.start),
      ],
    );
  }
}

class _ApiLabRuleRow extends StatelessWidget {
  const _ApiLabRuleRow({
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
