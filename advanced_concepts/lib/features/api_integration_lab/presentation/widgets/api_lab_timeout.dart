import 'package:advanced_concepts/features/api_integration_lab/presentation/widgets/api_lab_call_pad.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:advanced_concepts/shared_widgets/lab_compare_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiLabTimeouts {
  const ApiLabTimeouts({
    this.unguarded = const Duration(seconds: 30),
    this.guarded = const Duration(milliseconds: 400),
  });

  final Duration unguarded;
  final Duration guarded;
}

final apiLabTimeoutsProvider = Provider<ApiLabTimeouts>((ref) {
  return const ApiLabTimeouts();
});

class ApiLabTimeout extends ConsumerWidget {
  const ApiLabTimeout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final timeouts = ref.watch(apiLabTimeoutsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.apiTimeoutTitle, style: textTheme.titleSmall),
        const SizedBox(height: 8),
        LabCompareFrame(
          ok: false,
          title: l10n.apiTimeoutWrongTitle,
          hint: l10n.apiTimeoutWrongHint,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CodeSnippet(l10n.apiTimeoutCallWrong),
              const SizedBox(height: 8),
              ApiLabCallPad(
                buttonKey: const Key('api-lab-timeout-wrong'),
                label: l10n.apiCallTimeout,
                onCall: (ref) =>
                    apiLabFetchTimeout(ref, timeout: timeouts.unguarded),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        LabCompareFrame(
          ok: true,
          title: l10n.apiTimeoutRightTitle,
          hint: l10n.apiTimeoutRightHint,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CodeSnippet(l10n.apiTimeoutCallRight),
              const SizedBox(height: 8),
              ApiLabCallPad(
                buttonKey: const Key('api-lab-timeout-right'),
                label: l10n.apiCallTimeout,
                onCall: (ref) =>
                    apiLabFetchTimeout(ref, timeout: timeouts.guarded),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
