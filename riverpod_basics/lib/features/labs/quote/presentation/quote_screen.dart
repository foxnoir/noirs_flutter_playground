import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/quote/data/data_sources/in_memory_quote_data_source.dart';
import 'package:riverpod_basics/features/labs/quote/presentation/providers/quote_provider.dart';
import 'package:riverpod_basics/features/labs/quote/presentation/widgets/quote_async_card.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';
import 'package:riverpod_basics/shared_widgets/lab_info_text.dart';

class QuoteScreen extends ConsumerWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final quote = ref.watch(quoteProvider);
    final fromInput = ref.watch(quoteFromInputProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.quote)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          LabInfoText(l10n.quoteBody),
          const SizedBox(height: 16),
          QuoteAsyncCard(
            key: const Key('quoteNoInputCard'),
            quote: quote,
            label: l10n.quoteWatchLabel,
            background: scheme.primaryContainer,
            foreground: scheme.onPrimaryContainer,
          ),
          const SizedBox(height: 12),
          FullWidthElevatedButton(
            label: l10n.quoteReload,
            onPressed: quote.isLoading
                ? null
                : () => ref.invalidate(quoteProvider),
          ),
          const SizedBox(height: 12),
          FullWidthElevatedButton(
            label: l10n.quoteFailCall,
            onPressed: quote.isLoading
                ? null
                : () {
                    ref.read(quoteDataSourceProvider).failCall();
                    ref.invalidate(quoteProvider);
                  },
          ),
          const SizedBox(height: 16),
          QuoteAsyncCard(
            key: const Key('quoteFromInputCard'),
            quote: fromInput,
            label: l10n.quoteFromInputLabel,
            background: scheme.secondaryContainer,
            foreground: scheme.onSecondaryContainer,
          ),
          const SizedBox(height: 12),
          FullWidthElevatedButton(
            label: l10n.quoteIncrementNumber,
            onPressed: fromInput.isLoading
                ? null
                : () => ref
                      .read(quoteNumberProvider.notifier)
                      .incrementQuoteNumber(),
          ),
        ],
      ),
    );
  }
}
