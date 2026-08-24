import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/async_notifier_persistent_state/presentation/providers/async_notifier_persistent_state.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class AsyncNotifierPersistentStateScreen extends ConsumerWidget {
  const AsyncNotifierPersistentStateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    // watch is AsyncValue<int>, not int.
    final counter = ref.watch(persistentStateAsyncNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.asyncNotifierPersistentState)),
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
          error: (error, _) => Center(child: Text('$error')),
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
                          heroTag: 'async-notifier-persistent-decrement',
                          onPressed: () {
                            ref
                                .read(
                                  persistentStateAsyncNotifierProvider.notifier,
                                )
                                .decrement();
                          },
                          child: const Icon(Icons.remove),
                        ),
                        FloatingActionButton(
                          heroTag: 'async-notifier-persistent-increment',
                          onPressed: () {
                            ref
                                .read(
                                  persistentStateAsyncNotifierProvider.notifier,
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
                child: FloatingActionButton(
                  heroTag: 'async-notifier-persistent-reset',
                  onPressed: () {
                    ref
                        .read(persistentStateAsyncNotifierProvider.notifier)
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
