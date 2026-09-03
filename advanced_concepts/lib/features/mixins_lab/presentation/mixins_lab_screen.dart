import 'package:advanced_concepts/features/mixins_lab/presentation/mixins_lab_calls.dart';
import 'package:advanced_concepts/features/mixins_lab/presentation/widgets/mixins_lab_reload_card.dart';
import 'package:advanced_concepts/features/mixins_lab/presentation/widgets/mixins_lab_save_button.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_compare_frame.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_info_text.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_screen_body.dart';
import 'package:flutter/material.dart';

class MixinsLabScreen extends StatelessWidget {
  const MixinsLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.mixins)),
      body: LabScreenBody(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            LabInfoText(l10n.mixinsHint, textAlign: TextAlign.start),
            const SizedBox(height: 16),
            LabCompareFrame(
              ok: false,
              title: l10n.mixinsWrongTitle,
              hint: l10n.mixinsWrongHint,
              child: const CodeSnippet(MixinsLabCalls.illegal),
            ),
            const SizedBox(height: 12),
            LabCompareFrame(
              ok: true,
              title: l10n.mixinsRightTitle,
              hint: l10n.mixinsRightHint,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const MixinsLabSaveButton(),
                  const SizedBox(height: 8),
                  const MixinsLabReloadCard(),
                  const SizedBox(height: 12),
                  Text(l10n.mixinsWithLabel, style: textTheme.labelLarge),
                  const SizedBox(height: 4),
                  const CodeSnippet(MixinsLabCalls.withMixin),
                  const SizedBox(height: 12),
                  Text(l10n.mixinsMixinLabel, style: textTheme.labelLarge),
                  const SizedBox(height: 4),
                  const CodeSnippet(MixinsLabCalls.mixinSource),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
