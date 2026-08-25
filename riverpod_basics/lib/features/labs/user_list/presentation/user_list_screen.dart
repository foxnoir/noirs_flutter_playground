import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({super.key});

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(userListProvider.notifier).ensureLoaded();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final listState = ref.watch(userListProvider);

    ref.listen(userListProvider.select((state) => state.error), (_, error) {
      if (error == null) return;
      showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(l10n.errorTitle),
            content: Text(
              error == fetchUsersError ? l10n.fetchUsersFailed : error,
            ),
          );
        },
      );
      ref.read(userListProvider.notifier).clearError();
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.userList)),
      body: listState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: listState.users.length,
              itemBuilder: (context, index) {
                final user = listState.users[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(user.username),
                  subtitle: Text('${user.email} · ${user.age}'),
                  leading: Text('${user.id}'),
                );
              },
            ),
    );
  }
}
