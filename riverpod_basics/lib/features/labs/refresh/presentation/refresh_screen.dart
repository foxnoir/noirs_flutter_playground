import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/errors/app_failure_message.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/providers/refresh_provider.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/widgets/refresh_blink_button.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/widgets/refresh_info_card.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';
import 'package:riverpod_basics/shared_widgets/lab_intro_copy.dart';

String _clock(DateTime fetchedAt) {
  final hour = fetchedAt.hour.toString().padLeft(2, '0');
  final minute = fetchedAt.minute.toString().padLeft(2, '0');
  final second = fetchedAt.second.toString().padLeft(2, '0');
  return '$hour:$minute:$second';
}

/// The ping lives on [refreshPingProvider]. Refresh buttons track
/// whether they are still awaiting their Future(s).
class RefreshScreen extends ConsumerStatefulWidget {
  const RefreshScreen({super.key});

  @override
  ConsumerState<RefreshScreen> createState() => _RefreshScreenState();
}

class _RefreshScreenState extends ConsumerState<RefreshScreen> {
  /// 0 = idle, 1 = Refresh awaits one Future, 3 = Refresh 3x awaits.
  /// Both Refresh buttons read this so only one await runs at a time.
  var _awaitingFutureCount = 0;
  var _refreshBlinking = false;
  var _refreshThreeBlinking = false;

  bool get _isAwaiting => _awaitingFutureCount > 0;

  Future<void> _blinkRefreshButton({
    required int times,
    required bool three,
  }) async {
    const onFor = Duration(milliseconds: 140);
    const offFor = Duration(milliseconds: 100);
    for (var i = 0; i < times; i++) {
      if (!mounted) return;
      setState(() {
        if (three) {
          _refreshThreeBlinking = true;
        } else {
          _refreshBlinking = true;
        }
      });
      await Future<void>.delayed(onFor);
      if (!mounted) return;
      setState(() {
        if (three) {
          _refreshThreeBlinking = false;
        } else {
          _refreshBlinking = false;
        }
      });
      await Future<void>.delayed(offFor);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final ping = ref.watch(refreshPingProvider);
    final isLoading = ping.isLoading;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.refreshLab)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(refreshPingProvider.future),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            LabIntroCopy(l10n.refreshLabBody),
            const SizedBox(height: 16),
            RefreshInfoCard(
              label: l10n.refreshLabWatchLabel,
              body: ping.when(
                skipLoadingOnRefresh: false,
                skipLoadingOnReload: false,
                loading: () => l10n.refreshLabLoading,
                error: (error, _) => localizedError(l10n, error),
                data: (result) =>
                    l10n.refreshLabPing(result.n, _clock(result.fetchedAt)),
              ),
              background: scheme.primaryContainer,
              foreground: scheme.onPrimaryContainer,
              isActive: ping.hasValue && !isLoading,
            ),
            const SizedBox(height: 16),
            RefreshBlinkButton(
              label: _awaitingFutureCount == 1
                  ? l10n.refreshLabWaitingOnFuture
                  : l10n.refreshLabRefresh,
              isBlinking: _refreshBlinking,
              onPressed: _isAwaiting
                  ? null
                  : () async {
                      setState(() => _awaitingFutureCount = 1);
                      try {
                        final resultFuture = ref.refresh(
                          refreshPingProvider.future,
                        );
                        final blink = _blinkRefreshButton(
                          times: 1,
                          three: false,
                        );
                        final result = await resultFuture;
                        await blink;
                        if (result.n < 1) return;
                      } finally {
                        if (mounted) {
                          setState(() => _awaitingFutureCount = 0);
                        }
                      }
                    },
            ),
            const SizedBox(height: 12),
            FullWidthElevatedButton(
              label: l10n.refreshLabInvalidate,
              onPressed: () {
                ref.invalidate(refreshPingProvider);
              },
            ),
            const SizedBox(height: 12),
            RefreshBlinkButton(
              label: _awaitingFutureCount == 3
                  ? l10n.refreshLabWaitingOnThreeFutures
                  : l10n.refreshLabRefreshThree,
              isBlinking: _refreshThreeBlinking,
              onPressed: _isAwaiting
                  ? null
                  : () async {
                      setState(() => _awaitingFutureCount = 3);
                      try {
                        final first = ref.refresh(refreshPingProvider.future);
                        final second = ref.refresh(refreshPingProvider.future);
                        unawaited(first);
                        unawaited(second);
                        final thirdFuture = ref.refresh(
                          refreshPingProvider.future,
                        );
                        final blink = _blinkRefreshButton(
                          times: 3,
                          three: true,
                        );
                        final third = await thirdFuture;
                        await blink;
                        if (third.n < 1) return;
                      } finally {
                        if (mounted) {
                          setState(() => _awaitingFutureCount = 0);
                        }
                      }
                    },
            ),
            const SizedBox(height: 12),
            FullWidthElevatedButton(
              label: l10n.refreshLabInvalidateThree,
              onPressed: () {
                // Three marks, one scheduled rebuild. Count +1.
                ref
                  ..invalidate(refreshPingProvider)
                  ..invalidate(refreshPingProvider)
                  ..invalidate(refreshPingProvider);
              },
            ),
          ],
        ),
      ),
    );
  }
}
