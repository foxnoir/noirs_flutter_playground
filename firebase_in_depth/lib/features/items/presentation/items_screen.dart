import 'package:firebase_in_depth/core/errors/app_failure_message.dart';
import 'package:firebase_in_depth/core/router/app_router_names.dart';
import 'package:firebase_in_depth/features/items/presentation/providers/item_list_provider.dart';
import 'package:firebase_in_depth/features/items/presentation/widgets/items_row.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:firebase_in_depth/shared_widgets/error_widget.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ItemsScreen extends ConsumerWidget {
  const ItemsScreen({super.key});

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
            return ItemsRow(
              item: item,
              onTap: () {
                context.pushNamed(
                  AppRouteNames.itemDetails,
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
