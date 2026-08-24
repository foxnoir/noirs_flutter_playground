import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/providers/state_provider/presentation/providers/state_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final counter = ref.watch(counterStateProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.stateProvider)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  heroTag: 'state-provider-decrement',
                  onPressed: () {
                    ref.read(counterStateProvider.notifier).state--;
                  },
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: 'state-provider-increment',
                  onPressed: () {
                    ref.read(counterStateProvider.notifier).state++;
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
