import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/errors/app_failure_message.dart';
import 'package:riverpod_basics/features/labs/tick/domain/entities/tick.dart';
import 'package:riverpod_basics/features/labs/tick/presentation/widgets/tick_result_card.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/error_widget.dart';

String formatTickClock(DateTime emittedAt) {
  final hour = emittedAt.hour.toString().padLeft(2, '0');
  final minute = emittedAt.minute.toString().padLeft(2, '0');
  final second = emittedAt.second.toString().padLeft(2, '0');
  return '$hour:$minute:$second';
}

class TickAsyncCard extends StatelessWidget {
  const TickAsyncCard({
    required this.tick,
    required this.label,
    required this.background,
    required this.foreground,
    super.key,
  });

  final AsyncValue<Tick> tick;
  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return tick.when(
      skipLoadingOnReload: false,
      skipLoadingOnRefresh: false,
      loading: () => TickResultCard(
        label: label,
        background: background,
        foreground: foreground,
        isLoading: true,
      ),
      error: (error, _) => ErrorWidget(message: localizedError(l10n, error)),
      data: (value) => TickResultCard(
        label: label,
        background: background,
        foreground: foreground,
        isLoading: false,
        body: l10n.tickBeat(value.n, formatTickClock(value.emittedAt)),
      ),
    );
  }
}
