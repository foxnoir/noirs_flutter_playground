import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_compare_frame.dart';
import 'package:flutter/material.dart';

class LayoutLabPreferredSize extends StatelessWidget {
  const LayoutLabPreferredSize({super.key});

  static const customHeight = 96.0;
  static const frameHeight = 160.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.layoutPreferredTitle, style: textTheme.titleSmall),
        const SizedBox(height: 8),
        LabCompareFrame(
          ok: true,
          title: '${l10n.layoutPreferredAppBar}  ·  56',
          hint: l10n.layoutPreferredAppBarHint,
          child: _LayoutLabPreferredFrame(
            bar: AppBar(
              automaticallyImplyLeading: false,
              primary: false,
              title: Text(l10n.layoutPreferredAppBar),
            ),
          ),
        ),
        const SizedBox(height: 4),
        CodeSnippet(l10n.layoutPreferredCallAppBar),
        const SizedBox(height: 12),
        LabCompareFrame(
          ok: true,
          title: '${l10n.layoutPreferredCustom}  ·  96',
          hint: l10n.layoutPreferredCustomHint,
          child: _LayoutLabPreferredFrame(
            bar: PreferredSize(
              preferredSize: const Size.fromHeight(
                LayoutLabPreferredSize.customHeight,
              ),
              child: ColoredBox(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Center(
                  child: Text(
                    l10n.layoutPreferredCustom,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        CodeSnippet(l10n.layoutPreferredCallCustom),
      ],
    );
  }
}

class _LayoutLabPreferredFrame extends StatelessWidget {
  const _LayoutLabPreferredFrame({required this.bar});

  final PreferredSizeWidget bar;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: LayoutLabPreferredSize.frameHeight,
        child: Scaffold(
          appBar: bar,
          body: ColoredBox(
            color: scheme.secondaryContainer,
            child: Center(
              child: Text(
                '${l10n.layoutPreferredBody}  ·  ${bar.preferredSize.height.toInt()}',
                key: bar is PreferredSize
                    ? const Key('layout-lab-preferred-body')
                    : const Key('layout-lab-appbar-body'),
                style: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
