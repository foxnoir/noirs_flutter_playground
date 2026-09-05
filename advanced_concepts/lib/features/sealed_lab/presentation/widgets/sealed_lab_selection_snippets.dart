import 'package:advanced_concepts/features/sealed_lab/presentation/providers/sealed_lab_book_format_provider.dart';
import 'package:advanced_concepts/features/sealed_lab/presentation/widgets/sealed_lab_code_snippets.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SealedLabSelectionSnippets extends ConsumerWidget {
  const SealedLabSelectionSnippets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final selected = ref.watch(sealedLabBookFormatProvider).value?.selected;
    if (selected == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.sealedSubclassLabel, style: textTheme.labelLarge),
        const SizedBox(height: 4),
        CodeSnippet(SealedLabCodeSnippets.subclass(selected)),
        const SizedBox(height: 12),
        Text(l10n.sealedSwitchLabel, style: textTheme.labelLarge),
        const SizedBox(height: 4),
        CodeSnippet(SealedLabCodeSnippets.formatSwitch(selected)),
      ],
    );
  }
}
