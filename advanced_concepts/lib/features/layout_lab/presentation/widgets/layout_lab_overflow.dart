import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_compare_frame.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_error_stripes.dart';
import 'package:flutter/material.dart';

class LayoutLabOverflow extends StatelessWidget {
  const LayoutLabOverflow({super.key});

  static const _labels = ['Alpha', 'Bravo', 'Charlie', 'Delta', 'Echo'];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.layoutOverflowTitle, style: textTheme.titleSmall),
        const SizedBox(height: 8),
        LabCompareFrame(
          ok: false,
          title: l10n.layoutOverflowWrongTitle,
          hint: l10n.layoutOverflowWrongHint,
          child: LabErrorStripes(message: l10n.layoutOverflowStripe),
        ),
        const SizedBox(height: 4),
        CodeSnippet(l10n.layoutOverflowCallWrong),
        const SizedBox(height: 12),
        LabCompareFrame(
          ok: true,
          title: l10n.layoutOverflowRightTitle,
          hint: l10n.layoutOverflowRightHint,
          child: SizedBox(
            height: 48,
            child: Row(
              children: [
                for (final label in _labels)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ColoredBox(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: Center(
                          child: Text(
                            label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        CodeSnippet(l10n.layoutOverflowCallRight),
      ],
    );
  }
}
