import 'package:flutter/material.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class NoProviderScreen extends StatefulWidget {
  const NoProviderScreen({super.key});

  @override
  State<NoProviderScreen> createState() => _NoProviderScreenState();
}

class _NoProviderScreenState extends State<NoProviderScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.noProvider)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  heroTag: 'no-provider-decrement',
                  onPressed: () {
                    setState(() {
                      _counter--;
                    });
                  },
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: 'no-provider-increment',
                  onPressed: () {
                    setState(() {
                      _counter++;
                    });
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(l10n.buttonPressCount(_counter)),
          ],
        ),
      ),
    );
  }
}
