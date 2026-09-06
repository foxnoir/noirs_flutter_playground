import 'package:firebase_depth/core/errors/app_failure_message.dart';
import 'package:firebase_depth/features/items/presentation/providers/item_provider.dart';
import 'package:firebase_depth/l10n/app_localizations.dart';
import 'package:firebase_depth/shared_widgets/error_widget.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemDetailPage extends ConsumerWidget {
  const ItemDetailPage({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final item = ref.watch(itemProvider(id));

    return Scaffold(
      appBar: AppBar(title: Text(item.asData?.value.title ?? l10n.itemDetail)),
      body: item.when(
        skipLoadingOnReload: false,
        skipLoadingOnRefresh: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorWidget(
          message: localizedError(l10n, error),
          retryLabel: l10n.retry,
          onRetry: () {
            ref.read(itemProvider(id).notifier).retry();
          },
        ),
        data: (item) => Padding(
          padding: const EdgeInsets.all(16),
          child: Text(item.subtitle),
        ),
      ),
    );
  }
}
