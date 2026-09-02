import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:advanced_concepts/shared_widgets/lab_compare_frame.dart';
import 'package:flutter/material.dart';

class ApiLabTimeout extends StatelessWidget {
  const ApiLabTimeout({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.apiTimeoutTitle, style: textTheme.titleSmall),
        const SizedBox(height: 8),
        LabCompareFrame(
          ok: false,
          title: l10n.apiTimeoutWrongTitle,
          hint: l10n.apiTimeoutWrongHint,
          child: CodeSnippet(l10n.apiTimeoutCallWrong),
        ),
        const SizedBox(height: 8),
        LabCompareFrame(
          ok: true,
          title: l10n.apiTimeoutRightTitle,
          hint: l10n.apiTimeoutRightHint,
          child: CodeSnippet(l10n.apiTimeoutCallRight),
        ),
      ],
    );
  }
}
