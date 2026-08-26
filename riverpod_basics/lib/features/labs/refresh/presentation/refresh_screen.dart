import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/providers/refresh_provider.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/widgets/refresh_info_card.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

String _clock(DateTime fetchedAt) {
  final hour = fetchedAt.hour.toString().padLeft(2, '0');
  final minute = fetchedAt.minute.toString().padLeft(2, '0');
  final second = fetchedAt.second.toString().padLeft(2, '0');
  return '$hour:$minute:$second';
}

/// One watched fake GET. The time lives on [refreshPingProvider].
class RefreshScreen extends ConsumerWidget {
  const RefreshScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    // Subscribe. When the GET runs again, this rebuilds.
    final ping = ref.watch(refreshPingProvider);
    final isLoading = ping.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.refreshLab)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.refreshLabBody),
            const SizedBox(height: 16),
            Expanded(
              child: RefreshIndicator(
                // RefreshIndicator needs a Future. invalidate is void,
                // so it cannot go here.
                onRefresh: () => ref.refresh(refreshPingProvider.future),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    RefreshInfoCard(
                      label: l10n.refreshLabWatchLabel,
                      body: ping.when(
                        skipLoadingOnRefresh: false,
                        skipLoadingOnReload: false,
                        loading: () => l10n.refreshLabLoading,
                        error: (_, _) => l10n.errorOccurred,
                        data: (fetchedAt) =>
                            l10n.refreshLabPing(_clock(fetchedAt)),
                      ),
                      background: scheme.primaryContainer,
                      foreground: scheme.onPrimaryContainer,
                      isActive: ping.hasValue && !isLoading,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            FullWidthElevatedButton(
              label: l10n.refreshLabRefresh,
              onPressed: isLoading
                  ? null
                  : () async {
                      // Same Future as pull-to-refresh. watch shows the time.
                      final fetchedAt = await ref.refresh(
                        refreshPingProvider.future,
                      );
                      if (fetchedAt.year < 1) return;
                    },
            ),
            const SizedBox(height: 12),
            FullWidthElevatedButton(
              label: l10n.refreshLabInvalidate,
              onPressed: isLoading
                  ? null
                  : () {
                      // void — no Future to wait on. The GET still starts
                      // because this widget watches the provider.
                      ref.invalidate(refreshPingProvider);
                    },
            ),
          ],
        ),
      ),
    );
  }
}
