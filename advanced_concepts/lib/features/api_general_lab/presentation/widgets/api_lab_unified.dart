import 'package:advanced_concepts/features/api_general_lab/presentation/widgets/api_lab_call_pad.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:advanced_concepts/shared_widgets/lab_compare_frame.dart';
import 'package:flutter/material.dart';

class ApiLabUnified extends StatelessWidget {
  const ApiLabUnified({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.apiUnifiedTitle, style: textTheme.titleSmall),
        const SizedBox(height: 8),
        LabCompareFrame(
          ok: false,
          title: l10n.apiUnifiedWrongTitle,
          hint: l10n.apiUnifiedWrongHint,
          child: CodeSnippet(l10n.apiUnifiedCallWrong),
        ),
        const SizedBox(height: 8),
        LabCompareFrame(
          ok: true,
          title: l10n.apiUnifiedRightTitle,
          hint: l10n.apiUnifiedRightHint,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CodeSnippet(l10n.apiUnifiedCallRight),
              const SizedBox(height: 8),
              ApiLabCallPad(
                buttonKey: const Key('api-lab-books'),
                label: l10n.apiCallBooks,
                onCall: apiLabFetchBooks,
              ),
              const SizedBox(height: 8),
              ApiLabCallPad(
                buttonKey: const Key('api-lab-success'),
                label: l10n.apiCallSuccess,
                onCall: apiLabFetchSuccess,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
