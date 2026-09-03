import 'package:advanced_concepts/features/mixins_lab/presentation/mixins_lab_busy_tap.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MixinsLabSaveButton extends StatefulWidget {
  const MixinsLabSaveButton({super.key});

  @override
  State<MixinsLabSaveButton> createState() => _MixinsLabSaveButtonState();
}

class _MixinsLabSaveButtonState extends State<MixinsLabSaveButton>
    with MixinsLabBusyTap {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return FilledButton.icon(
      key: const Key('mixins-lab-save'),
      onPressed: busy
          ? null
          : () => runBusy(() => Future<void>.delayed(mixinsLabBusyDelay)),
      icon: busy
          ? const SizedBox(
              key: Key('mixins-lab-save-busy'),
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.save_outlined),
      label: Text(busy ? l10n.mixinsBusy : l10n.mixinsSave),
    );
  }
}
