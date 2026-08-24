import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/notifier_provider/presentation/providers/notifier_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class NotifierProviderScreen extends ConsumerWidget {
  const NotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final counter = ref.watch(counterNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.notifierProvider)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  heroTag: 'notifier-provider-decrement',
                  onPressed: () {
                    ref.read(counterNotifierProvider.notifier).decrement();
                  },
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: 'notifier-provider-increment',
                  onPressed: () {
                    ref.read(counterNotifierProvider.notifier).increment();
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(l10n.buttonPressCount(counter)),
          ],
        ),
      ),
    );
  }
}
