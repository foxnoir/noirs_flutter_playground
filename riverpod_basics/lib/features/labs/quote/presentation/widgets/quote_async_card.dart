import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/errors/app_failure_message.dart';
import 'package:riverpod_basics/features/labs/quote/domain/entities/quote.dart';
import 'package:riverpod_basics/features/labs/quote/presentation/widgets/quote_result_card.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/error_widget.dart';

class QuoteAsyncCard extends StatelessWidget {
  const QuoteAsyncCard({
    required this.quote,
    required this.label,
    required this.background,
    required this.foreground,
    super.key,
  });

  final AsyncValue<Quote> quote;
  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return quote.when(
      skipLoadingOnReload: false,
      skipLoadingOnRefresh: false,
      loading: () => QuoteResultCard(
        label: label,
        background: background,
        foreground: foreground,
        isLoading: true,
      ),
      error: (error, _) => ErrorWidget(message: localizedError(l10n, error)),
      data: (value) => QuoteResultCard(
        label: label,
        background: background,
        foreground: foreground,
        isLoading: false,
        text: value.text,
        author: value.author,
      ),
    );
  }
}
