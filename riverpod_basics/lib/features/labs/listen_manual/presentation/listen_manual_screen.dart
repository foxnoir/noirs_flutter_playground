import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/listen_manual/presentation/providers/listen_manual_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

class ListenManualScreen extends ConsumerStatefulWidget {
  const ListenManualScreen({super.key});

  @override
  ConsumerState<ListenManualScreen> createState() => _ListenManualScreenState();
}

class _ListenManualScreenState extends ConsumerState<ListenManualScreen> {
  late final ProviderSubscription<String?> _errorSubscription;
  late final String? _readSnapshot;
  var _manualSawCurrentValue = false;
  var _listenSawChange = false;
  var _isFirstManualCallback = true;

  @override
  void initState() {
    super.initState();
    // Legal in initState. One-shot: the value *now*, no subscription.
    // Tapping Store later will not update this snapshot. No dialog.
    _readSnapshot = ref.read(listenManualErrorProvider);
    // `ref.listen` is only legal in `build`. This is `initState`, so
    // `listenManual`. `fireImmediately: true` also delivers the value that
    // is already on the provider — not only later changes.
    _errorSubscription = ref.listenManual<String?>(listenManualErrorProvider, (
      previous,
      next,
    ) {
      final alreadyStored = _isFirstManualCallback && next != null;
      _isFirstManualCallback = false;
      if (next == null) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (alreadyStored) {
          setState(() => _manualSawCurrentValue = true);
        }
        _showErrorDialog(next);
      });
    }, fireImmediately: true);
  }

  @override
  void dispose() {
    _errorSubscription.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final error = ref.watch(listenManualErrorProvider);

    // Same provider, same callback shape — but only if the value *changes*
    // while this screen is open. Coming back with an error already stored
    // does not count as a change.
    ref.listen<String?>(listenManualErrorProvider, (previous, next) {
      if (next == null) return;
      setState(() => _listenSawChange = true);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: scheme.tertiaryContainer,
            content: Text(
              l10n.listenManualListenSnackBar,
              style: TextStyle(color: scheme.onTertiaryContainer),
            ),
          ),
        );
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.listenManual)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.listenManualBody),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _SourceCard(
                    label: l10n.listenManualWatchLabel,
                    body: error == null
                        ? l10n.listenManualIdle
                        : l10n.listenManualStored,
                    background: scheme.primaryContainer,
                    foreground: scheme.onPrimaryContainer,
                    isActive: error != null,
                  ),
                  const SizedBox(height: 8),
                  _SourceCard(
                    label: l10n.listenManualReadLabel,
                    body: _readSnapshot == null
                        ? l10n.listenManualReadIdle
                        : l10n.listenManualReadFired,
                    background: scheme.surfaceContainerHighest,
                    foreground: scheme.onSurface,
                    isActive: _readSnapshot != null,
                  ),
                  const SizedBox(height: 8),
                  _SourceCard(
                    label: l10n.listenManualManualLabel,
                    body: _manualSawCurrentValue
                        ? l10n.listenManualManualFired
                        : l10n.listenManualManualIdle,
                    background: scheme.errorContainer,
                    foreground: scheme.onErrorContainer,
                    isActive: _manualSawCurrentValue,
                  ),
                  const SizedBox(height: 8),
                  _SourceCard(
                    label: l10n.listenManualListenLabel,
                    body: _listenSawChange
                        ? l10n.listenManualListenFired
                        : l10n.listenManualListenIdle,
                    background: scheme.tertiaryContainer,
                    foreground: scheme.onTertiaryContainer,
                    isActive: _listenSawChange,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FullWidthElevatedButton(
              label: l10n.listenManualStoreError,
              onPressed: () {
                ref.read(listenManualErrorProvider.notifier).storeError();
              },
            ),
            const SizedBox(height: 12),
            FullWidthElevatedButton(
              label: l10n.listenManualClearError,
              onPressed: error == null
                  ? null
                  : () {
                      ref.read(listenManualErrorProvider.notifier).clearError();
                    },
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String error) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: scheme.errorContainer,
          title: Text(
            l10n.errorTitle,
            style: TextStyle(color: scheme.onErrorContainer),
          ),
          content: Text(
            error == listenManualFetchError
                ? l10n.listenManualFetchFailed
                : error,
            style: TextStyle(color: scheme.onErrorContainer),
          ),
        );
      },
    );
  }
}

/// One colored card per API so watch / read / listenManual / listen stay distinct.
class _SourceCard extends StatelessWidget {
  const _SourceCard({
    required this.label,
    required this.body,
    required this.background,
    required this.foreground,
    required this.isActive,
  });

  final String label;
  final String body;
  final Color background;
  final Color foreground;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Opacity(
      opacity: isActive ? 1 : 0.55,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: foreground.withValues(alpha: isActive ? 0.8 : 0.25),
            width: isActive ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.labelLarge?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: textTheme.bodyMedium?.copyWith(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
