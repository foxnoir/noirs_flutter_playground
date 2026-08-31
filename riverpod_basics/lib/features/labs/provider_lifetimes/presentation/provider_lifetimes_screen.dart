import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/providers/lifetimes_auto_dispose_provider.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/providers/lifetimes_keep_alive_provider.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/providers/lifetimes_persistent_provider.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/widgets/provider_lifetimes_section.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class ProviderLifetimesScreen extends ConsumerStatefulWidget {
  const ProviderLifetimesScreen({super.key});

  @override
  ConsumerState<ProviderLifetimesScreen> createState() =>
      _ProviderLifetimesScreenState();
}

class _ProviderLifetimesScreenState
    extends ConsumerState<ProviderLifetimesScreen> {
  late final TextEditingController _persistentController;
  late final TextEditingController _nonPersistentController;
  late final TextEditingController _keepAliveController;

  @override
  void initState() {
    super.initState();
    _persistentController = TextEditingController();
    _nonPersistentController = TextEditingController();
    _keepAliveController = TextEditingController();
  }

  @override
  void dispose() {
    _persistentController.dispose();
    _nonPersistentController.dispose();
    _keepAliveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final persistentUser = ref.watch(lifetimesPersistentProvider);
    final nonPersistentUser = ref.watch(lifetimesAutoDisposeProvider);
    final keepAliveUser = ref.watch(lifetimesKeepAliveProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.providerLifetimes)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ProviderLifetimesSection(
                key: const Key('lifetimes-persistent'),
                title: l10n.persistent,
                user: persistentUser,
                controller: _persistentController,
                onAddPressed: () {
                  ref
                      .read(lifetimesPersistentProvider.notifier)
                      .setUser(_persistentController.text);
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: ProviderLifetimesSection(
                key: const Key('lifetimes-non-persistent'),
                title: l10n.nonPersistent,
                user: nonPersistentUser,
                controller: _nonPersistentController,
                onAddPressed: () {
                  ref
                      .read(lifetimesAutoDisposeProvider.notifier)
                      .setUser(_nonPersistentController.text);
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: ProviderLifetimesSection(
                key: const Key('lifetimes-keep-alive'),
                title: l10n.keepAliveForSeconds(keepAliveDuration.inSeconds),
                user: keepAliveUser,
                controller: _keepAliveController,
                onAddPressed: () {
                  ref
                      .read(lifetimesKeepAliveProvider.notifier)
                      .setUser(_keepAliveController.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
