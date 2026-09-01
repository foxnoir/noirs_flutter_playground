import 'package:advanced_concepts/features/api_general_lab/presentation/widgets/api_lab_call_pad.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:advanced_concepts/shared_widgets/lab_compare_frame.dart';
import 'package:flutter/material.dart';

class ApiLabNetwork extends StatelessWidget {
  const ApiLabNetwork({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.apiNetworkTitle, style: textTheme.titleSmall),
        const SizedBox(height: 8),
        LabCompareFrame(
          ok: false,
          title: l10n.apiNetworkWrongTitle,
          hint: l10n.apiNetworkWrongHint,
          child: CodeSnippet(l10n.apiNetworkCallWrong),
        ),
        const SizedBox(height: 8),
        LabCompareFrame(
          ok: true,
          title: l10n.apiNetworkRightTitle,
          hint: l10n.apiNetworkRightHint,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CodeSnippet(l10n.apiNetworkCallRight),
              const SizedBox(height: 8),
              ApiLabCallPad(
                buttonKey: const Key('api-lab-error'),
                label: l10n.apiCallError,
                onCall: apiLabFetchError,
              ),
              const SizedBox(height: 8),
              ApiLabCallPad(
                buttonKey: const Key('api-lab-unauthorized'),
                label: l10n.apiCallUnauthorized,
                onCall: apiLabIdentifyWrong,
              ),
              const SizedBox(height: 8),
              ApiLabCallPad(
                buttonKey: const Key('api-lab-offline'),
                label: l10n.apiCallOffline,
                onCall: apiLabFetchOffline,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
