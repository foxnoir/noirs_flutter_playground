import 'package:advanced_concepts/features/mixins_lab/presentation/mixins_lab_busy_mixin.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MixinsLabReloadCard extends StatefulWidget {
  const MixinsLabReloadCard({super.key});

  @override
  State<MixinsLabReloadCard> createState() => _MixinsLabReloadCardState();
}

class _MixinsLabReloadCardState extends State<MixinsLabReloadCard>
    with MixinsLabBusyMixin {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: busy ? scheme.tertiaryContainer : scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(8),
      child: ListTile(
        key: const Key('mixins-lab-reload'),
        leading: busy
            ? SizedBox(
                key: const Key('mixins-lab-reload-busy'),
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: scheme.onTertiaryContainer,
                ),
              )
            : const Icon(Icons.refresh),
        title: Text(l10n.mixinsReload),
        subtitle: Text(busy ? l10n.mixinsBusy : l10n.mixinsIdle),
        onTap: busy
            ? null
            : () => runBusy(() => Future<void>.delayed(mixinsLabBusyDelay)),
      ),
    );
  }
}
