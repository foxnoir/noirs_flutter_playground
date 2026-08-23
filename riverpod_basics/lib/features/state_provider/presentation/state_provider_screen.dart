import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class StateProviderScreen extends ConsumerStatefulWidget {
  const StateProviderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<StateProviderScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class StateProviderScreen extends StatelessWidget {
//   const StateProviderScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final l10n = AppLocalizations.of(context);

//     return Scaffold(
//       appBar: AppBar(title: Text(l10n.stateProvider)),
//       body: Center(child: Text(l10n.counter)),
//     );
//   }
// }
