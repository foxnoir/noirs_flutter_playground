import 'package:advanced_concepts/features/generics_general_lab/presentation/generics_lab_code_snippets.dart';
import 'package:advanced_concepts/features/generics_general_lab/presentation/widgets/generics_lab_rows.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_compare_frame.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_info_text.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_screen_body.dart';
import 'package:flutter/material.dart';

class GenericsGeneralLabScreen extends StatelessWidget {
  const GenericsGeneralLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.genericsGeneral)),
      body: LabScreenBody(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            LabInfoText(l10n.genericsHint, textAlign: TextAlign.start),
            const SizedBox(height: 16),
            LabCompareFrame(
              ok: false,
              title: l10n.genericsWrongTitle,
              hint: l10n.genericsWrongHint,
              child: const CodeSnippet(GenericsLabCodeSnippets.twoTiles),
            ),
            const SizedBox(height: 12),
            LabCompareFrame(
              ok: true,
              title: l10n.genericsRightTitle,
              hint: l10n.genericsRightHint,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const GenericsLabRows(),
                  const SizedBox(height: 12),
                  Text(l10n.genericsTileLabel, style: textTheme.labelLarge),
                  const SizedBox(height: 4),
                  const CodeSnippet(GenericsLabCodeSnippets.tile),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
