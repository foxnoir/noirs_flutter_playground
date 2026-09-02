import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_compare_frame.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_error_stripes.dart';
import 'package:flutter/material.dart';

class LayoutLabBuilder extends StatelessWidget {
  const LayoutLabBuilder({super.key});

  static const parentWidth = 120.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final windowWidth = MediaQuery.sizeOf(context).width;
    final overflowPx = (windowWidth - parentWidth).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.layoutBuilderTitle, style: textTheme.titleSmall),
        const SizedBox(height: 8),
        LabCompareFrame(
          ok: false,
          title: l10n.layoutBuilderWrongTitle,
          hint: l10n.layoutBuilderWrongHint,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.layoutBuilderPaneChip(
                  parentWidth.round(),
                  windowWidth.round(),
                ),
                style: textTheme.labelSmall,
              ),
              const SizedBox(height: 8),
              LabErrorStripes(
                key: const Key('layout-lab-builder-overflow'),
                message: l10n.layoutBuilderStripe(overflowPx),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        CodeSnippet(l10n.layoutBuilderCallWrong),
        const SizedBox(height: 12),
        LabCompareFrame(
          ok: true,
          title: l10n.layoutBuilderRightTitle,
          hint: l10n.layoutBuilderRightHint,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.layoutBuilderPaneChip(
                  parentWidth.round(),
                  parentWidth.round(),
                ),
                style: textTheme.labelSmall,
              ),
              const SizedBox(height: 8),
              const SizedBox(
                height: 48,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _LayoutLabBuilderFit(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        CodeSnippet(l10n.layoutBuilderCallRight),
      ],
    );
  }
}

class _LayoutLabBuilderFit extends StatelessWidget {
  const _LayoutLabBuilderFit();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: LayoutLabBuilder.parentWidth,
      child: ColoredBox(
        key: const Key('layout-lab-builder-fit'),
        color: scheme.secondaryContainer,
        child: Center(
          child: Text(
            LayoutLabBuilder.parentWidth.round().toString(),
            style: textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
