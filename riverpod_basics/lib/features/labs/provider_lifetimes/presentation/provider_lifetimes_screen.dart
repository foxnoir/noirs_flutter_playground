import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/providers/add_user_keep_alive_provider.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/providers/add_user_non_persistent_provider.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/providers/add_user_provider.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/widgets/add_user_section.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class AddUserScreen extends ConsumerStatefulWidget {
  const AddUserScreen({super.key});

  @override
  ConsumerState<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends ConsumerState<AddUserScreen> {
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
    final persistentUser = ref.watch(addUserProvider);
    final nonPersistentUser = ref.watch(addUserNonPersistentProvider);
    final keepAliveUser = ref.watch(addUserKeepAliveProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addUser)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AddUserSection(
                key: const Key('add-user-persistent'),
                title: l10n.persistent,
                user: persistentUser,
                controller: _persistentController,
                onAddPressed: () {
                  ref.read(addUserProvider.notifier).user =
                      _persistentController.text;
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: AddUserSection(
                key: const Key('add-user-non-persistent'),
                title: l10n.nonPersistent,
                user: nonPersistentUser,
                controller: _nonPersistentController,
                onAddPressed: () {
                  ref.read(addUserNonPersistentProvider.notifier).user =
                      _nonPersistentController.text;
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: AddUserSection(
                key: const Key('add-user-keep-alive'),
                title: l10n.keepAliveForSeconds(
                  addUserKeepAliveDuration.inSeconds,
                ),
                user: keepAliveUser,
                controller: _keepAliveController,
                onAddPressed: () {
                  ref.read(addUserKeepAliveProvider.notifier).user =
                      _keepAliveController.text;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
