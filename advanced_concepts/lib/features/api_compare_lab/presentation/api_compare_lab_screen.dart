import 'package:advanced_concepts/features/api_compare_lab/presentation/providers/api_compare_lab_provider.dart';
import 'package:advanced_concepts/features/api_compare_lab/presentation/widgets/api_compare_lab_bar.dart';
import 'package:advanced_concepts/features/api_compare_lab/presentation/widgets/api_compare_lab_beats.dart';
import 'package:advanced_concepts/features/api_compare_lab/presentation/widgets/api_compare_lab_panel.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_info_text.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiCompareLabScreen extends ConsumerWidget {
  const ApiCompareLabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final walk = ref.watch(apiCompareLabProvider);
    final scenario = walk.scenario;
    final beats = scenario == null
        ? const <ApiCompareLabBeat>[]
        : apiCompareLabBeats(l10n, scenario);
    final lastStep = beats.isEmpty ? 0 : beats.length - 1;
    final canNext = scenario != null && walk.step < lastStep;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.apiCompare)),
      body: LabScreenBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ApiCompareLabBar(
              selected: scenario,
              onSelect: ref.read(apiCompareLabProvider.notifier).select,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LabInfoText(
                l10n.apiCompareHint,
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  FilledButton(
                    key: const Key('api-compare-lab-next'),
                    onPressed: canNext
                        ? () => ref
                              .read(apiCompareLabProvider.notifier)
                              .next(lastStep)
                        : null,
                    child: Text(l10n.apiCompareNext),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    key: const Key('api-compare-lab-reset'),
                    onPressed: scenario == null
                        ? null
                        : ref.read(apiCompareLabProvider.notifier).reset,
                    child: Text(l10n.apiCompareReset),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: scenario == null
                    ? Center(child: Text(l10n.apiCompareIdle))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ApiCompareLabPanel(
                              key: const Key('api-compare-lab-http'),
                              title: l10n.apiCompareHttpTitle,
                              beats: beats,
                              step: walk.step,
                              httpSide: true,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: ApiCompareLabPanel(
                              key: const Key('api-compare-lab-dio'),
                              title: l10n.apiCompareDioTitle,
                              beats: beats,
                              step: walk.step,
                              httpSide: false,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
