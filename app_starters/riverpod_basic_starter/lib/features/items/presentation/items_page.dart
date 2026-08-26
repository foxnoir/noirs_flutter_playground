import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_basic_starter/core/errors/app_failure_message.dart';
import 'package:riverpod_basic_starter/core/router/app_router_names.dart';
import 'package:riverpod_basic_starter/features/items/presentation/providers/item_list_provider.dart';
import 'package:riverpod_basic_starter/l10n/app_localizations.dart';
import 'package:riverpod_basic_starter/shared_widgets/error_widget.dart';

class ItemsPage extends ConsumerWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final items = ref.watch(itemListProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.items)),
      body: items.when(
        skipLoadingOnReload: false,
        skipLoadingOnRefresh: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorWidget(
          message: localizedError(l10n, error),
          retryLabel: l10n.retry,
          onRetry: () {
            ref.read(itemListProvider.notifier).retry();
          },
        ),
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: Text(item.title),
              subtitle: Text(item.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                context.pushNamed(
                  AppRouteNames.itemDetail,
                  pathParameters: {'itemId': '${item.id}'},
                );
              },
            );
          },
        ),
      ),
    );
  }
}
