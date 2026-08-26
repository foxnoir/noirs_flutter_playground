import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/errors/app_failure_message.dart';
import 'package:riverpod_basics/features/providers/async_notifier_non_persistent_state/presentation/providers/async_notifier_non_persistent_state.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/error_widget.dart';

class AsyncNotifierNonPersistentStateScreen extends ConsumerWidget {
  const AsyncNotifierNonPersistentStateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    // watch is AsyncValue<int>, not int. This listener is what keeps the
    // autoDispose provider alive; pop removes it and the notifier is gone.
    final counter = ref.watch(nonPersistentStateAsyncNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.asyncNotifierNonPersistentState)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        // when is a switch on that AsyncValue. Riverpod runs exactly one
        // callback: loading while build() awaits, error if the Future
        // threw, data with the int once it completes. Skip a named
        // argument and that state has no widget.
        // skipLoadingOnRefresh is true by default, so a reload keeps the
        // old number on screen. false = show the spinner as soon as
        // state is AsyncLoading (reset).
        child: counter.when(
          skipLoadingOnRefresh: false,
          skipLoadingOnReload: false,
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) =>
              ErrorWidget(message: localizedError(l10n, error)),
          data: (count) => Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          heroTag: 'async-notifier-non-persistent-decrement',
                          onPressed: () {
                            ref
                                .read(
                                  nonPersistentStateAsyncNotifierProvider
                                      .notifier,
                                )
                                .decrement();
                          },
                          child: const Icon(Icons.remove),
                        ),
                        FloatingActionButton(
                          heroTag: 'async-notifier-non-persistent-increment',
                          onPressed: () {
                            ref
                                .read(
                                  nonPersistentStateAsyncNotifierProvider
                                      .notifier,
                                )
                                .increment();
                          },
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(l10n.buttonPressCount(count)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                // Reset stays on this page. Back is what disposes autoDispose.
                child: FloatingActionButton(
                  heroTag: 'async-notifier-non-persistent-reset',
                  onPressed: () {
                    ref
                        .read(nonPersistentStateAsyncNotifierProvider.notifier)
                        .reset();
                  },
                  child: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
