import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/tick/presentation/providers/tick_provider.dart';
import 'package:riverpod_basics/features/labs/tick/presentation/widgets/tick_async_card.dart';
import 'package:riverpod_basics/features/labs/tick/presentation/widgets/tick_result_card.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';
import 'package:riverpod_basics/shared_widgets/lab_info_text.dart';

void _showTickSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1500),
      ),
    );
}

class TickScreen extends ConsumerWidget {
  const TickScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final running = ref.watch(tickRunningProvider);
    final tick = running ? ref.watch(tickProvider) : null;
    final hasError = tick != null && tick.hasError && !tick.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tick)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          LabInfoText(l10n.tickBody),
          const SizedBox(height: 16),
          if (tick == null)
            TickResultCard(
              key: const Key('tickCard'),
              label: l10n.tickWatchLabel,
              background: scheme.primaryContainer,
              foreground: scheme.onPrimaryContainer,
              isLoading: false,
              body: l10n.tickStopped,
            )
          else
            TickAsyncCard(
              key: const Key('tickCard'),
              tick: tick,
              label: l10n.tickWatchLabel,
              background: scheme.primaryContainer,
              foreground: scheme.onPrimaryContainer,
            ),
          const SizedBox(height: 16),
          FullWidthElevatedButton(
            key: const Key('tickStart'),
            label: l10n.tickStart,
            onPressed: running && !hasError
                ? null
                : () {
                    if (hasError) {
                      _showTickSnackBar(
                        context,
                        l10n.labSnackBarInvalidateWatch,
                      );
                      ref.invalidate(tickProvider);
                    } else {
                      ref.read(tickRunningProvider.notifier).start();
                      _showTickSnackBar(context, l10n.labSnackBarReadWatch);
                    }
                  },
          ),
          const SizedBox(height: 12),
          FullWidthElevatedButton(
            key: const Key('tickStop'),
            label: l10n.tickStop,
            onPressed: running
                ? () {
                    ref.read(tickRunningProvider.notifier).stop();
                    _showTickSnackBar(context, l10n.labSnackBarReadUnwatch);
                  }
                : null,
          ),
          const SizedBox(height: 12),
          FullWidthElevatedButton(
            key: const Key('tickReload'),
            label: l10n.tickReload,
            onPressed: !running || (tick?.isLoading ?? false)
                ? null
                : () {
                    _showTickSnackBar(context, l10n.labSnackBarInvalidateWatch);
                    ref.invalidate(tickProvider);
                  },
          ),
          const SizedBox(height: 12),
          FullWidthElevatedButton(
            key: const Key('tickFailCall'),
            label: l10n.tickFailCall,
            onPressed: running
                ? () {
                    ref.read(tickFailCallProvider.notifier).failCall();
                    _showTickSnackBar(context, l10n.labSnackBarRead);
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
