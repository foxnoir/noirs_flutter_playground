import 'package:advanced_concepts/core/errors/app_failure_message.dart';
import 'package:advanced_concepts/features/sealed_lab/presentation/providers/sealed_lab_book_format_provider.dart';
import 'package:advanced_concepts/features/sealed_lab/presentation/sealed_lab_book_format_labels.dart';
import 'package:advanced_concepts/features/sealed_lab/presentation/widgets/sealed_lab_format_tile.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SealedLabSwitchHint extends ConsumerWidget {
  const SealedLabSwitchHint({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final selected = ref.watch(sealedLabBookFormatProvider).value?.selected;
    if (selected == null) {
      return const SizedBox.shrink();
    }

    final scheme = Theme.of(context).colorScheme;
    return Text(
      'switch → ${sealedLabFormatName(selected, l10n)}',
      key: const Key('sealed-lab-switch'),
      style: Theme.of(context).textTheme.titleSmall
          ?.copyWith(color: scheme.tertiaryContainer),
    );
  }
}

class SealedLabBookFormatRow extends ConsumerWidget {
  const SealedLabBookFormatRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final formats = ref.watch(sealedLabBookFormatProvider);

    return formats.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Text(
        localizedError(l10n, error),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      data: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final format in state.formats) ...[
            SealedLabFormatTile(
              format: format,
              selected: state.selected == format,
              onTap: () {
                ref.read(sealedLabBookFormatProvider.notifier).select(format);
              },
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}
