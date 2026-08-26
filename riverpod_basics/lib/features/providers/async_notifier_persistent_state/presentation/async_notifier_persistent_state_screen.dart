import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/errors/app_failure_message.dart';
import 'package:riverpod_basics/features/providers/async_notifier_persistent_state/presentation/providers/async_notifier_persistent_state.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/error_widget.dart';

class AsyncNotifierPersistentStateScreen extends ConsumerStatefulWidget {
  const AsyncNotifierPersistentStateScreen({super.key});

  @override
  ConsumerState<AsyncNotifierPersistentStateScreen> createState() =>
      _AsyncNotifierPersistentStateScreenState();
}

class _AsyncNotifierPersistentStateScreenState
    extends ConsumerState<AsyncNotifierPersistentStateScreen> {
  @override
  void initState() {
    super.initState();
    // Count this visit once. Doing it in build() would increment on
    // every rebuild. build() on the notifier does not run again.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      ref.read(persistentStateAsyncNotifierProvider.notifier).onPageEntered();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // watch is AsyncValue<int>, not int. Pop does not dispose this
    // provider: no autoDispose, so the same notifier is still there.
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
                // Reset reloads on this page. Back still keeps the count.
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
