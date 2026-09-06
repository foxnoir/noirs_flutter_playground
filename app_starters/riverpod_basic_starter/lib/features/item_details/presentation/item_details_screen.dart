import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basic_starter/core/errors/app_failure_message.dart';
import 'package:riverpod_basic_starter/features/item_details/presentation/providers/item_details_provider.dart';
import 'package:riverpod_basic_starter/features/item_details/presentation/widgets/item_details_data.dart';
import 'package:riverpod_basic_starter/features/item_details/presentation/widgets/item_details_metadata.dart';
import 'package:riverpod_basic_starter/l10n/app_localizations.dart';
import 'package:riverpod_basic_starter/shared_widgets/error_widget.dart';

class ItemDetailsScreen extends ConsumerWidget {
  const ItemDetailsScreen({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final item = ref.watch(itemDetailsProvider(id));

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
            ref.read(itemDetailsProvider(id).notifier).retry();
          },
        ),
        data: (item) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ItemDetailsMetadata(item: item),
            const SizedBox(height: 16),
            ItemDetailsData(item: item),
          ],
        ),
      ),
    );
  }
}
