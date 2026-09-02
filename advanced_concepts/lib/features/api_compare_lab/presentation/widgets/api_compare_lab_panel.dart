import 'package:advanced_concepts/features/api_compare_lab/presentation/widgets/api_compare_lab_beats.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:flutter/material.dart';

class ApiCompareLabPanel extends StatelessWidget {
  const ApiCompareLabPanel({
    required this.title,
    required this.beats,
    required this.step,
    required this.httpSide,
    super.key,
  });

  final String title;
  final List<ApiCompareLabBeat> beats;
  final int step;
  final bool httpSide;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: textTheme.titleSmall?.copyWith(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                color: scheme.tertiaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: beats.length,
                separatorBuilder: (context, index) => const SizedBox(height: 6),
                itemBuilder: (context, i) {
                  return _ApiCompareLabStep(
                    beat: beats[i],
                    httpSide: httpSide,
                    active: i == step,
                    done: i < step,
                    pending: i > step,
                    firesLabel: l10n.apiCompareFires,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApiCompareLabStep extends StatelessWidget {
  const _ApiCompareLabStep({
    required this.beat,
    required this.httpSide,
    required this.active,
    required this.done,
    required this.pending,
    required this.firesLabel,
  });

  final ApiCompareLabBeat beat;
  final bool httpSide;
  final bool active;
  final bool done;
  final bool pending;
  final String firesLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final call = httpSide ? beat.httpCall : beat.dioCall;
    final hint = httpSide ? beat.httpHint : beat.dioHint;
    final color = pending
        ? scheme.outline
        : active
        ? scheme.tertiaryContainer
        : scheme.onSurface;

    return Opacity(
      opacity: pending ? 0.45 : 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: active
              ? scheme.primaryContainer.withValues(alpha: 0.45)
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                done
                    ? Icons.check_circle_outline
                    : active
                    ? Icons.play_arrow
                    : Icons.circle_outlined,
                size: 16,
                color: color,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: CodeSnippet(call, maxLines: 2)),
                        if (beat.fires) ...[
                          const SizedBox(width: 8),
                          Text(
                            firesLabel,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: color,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ],
                    ),
                    if (active) ...[
                      const SizedBox(height: 4),
                      Text(hint, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
