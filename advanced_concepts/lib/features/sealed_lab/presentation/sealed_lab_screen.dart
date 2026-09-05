import 'package:advanced_concepts/features/sealed_lab/presentation/widgets/sealed_lab_book_format_row.dart';
import 'package:advanced_concepts/features/sealed_lab/presentation/widgets/sealed_lab_code_snippets.dart';
import 'package:advanced_concepts/features/sealed_lab/presentation/widgets/sealed_lab_selection_snippets.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_compare_frame.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_info_text.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_screen_body.dart';
import 'package:flutter/material.dart';

class SealedLabScreen extends StatelessWidget {
  const SealedLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.sealed)),
      body: LabScreenBody(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            LabInfoText(l10n.sealedHint, textAlign: TextAlign.start),
            const SizedBox(height: 16),
            LabCompareFrame(
              ok: false,
              title: l10n.sealedWrongTitle,
              hint: l10n.sealedWrongHint,
              child: const CodeSnippet(SealedLabCodeSnippets.jsonSubclass),
            ),
            const SizedBox(height: 12),
            LabCompareFrame(
              ok: true,
              title: l10n.sealedRightTitle,
              hint: l10n.sealedRightHint,
              hintAtTop: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SealedLabSwitchHint(),
                  const SizedBox(height: 12),
                  Text(l10n.sealedSnippetLabel, style: textTheme.labelLarge),
                  const SizedBox(height: 4),
                  const CodeSnippet(SealedLabCodeSnippets.bookMetadata),
                  const SizedBox(height: 12),
                  const SealedLabBookFormatRow(),
                  const SealedLabSelectionSnippets(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
