import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/consumer_widget/presentation/widgets/consumer_widget_panel.dart';
import 'package:riverpod_basics/features/labs/consumer_widget/presentation/widgets/consumer_wrap_panel.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

/// Same list, two widget types. The UI matches because both `watch` the
/// same provider. The difference is only how they get `ref`.
class ConsumerWidgetScreen extends ConsumerStatefulWidget {
  const ConsumerWidgetScreen({super.key});

  @override
  ConsumerState<ConsumerWidgetScreen> createState() =>
      _ConsumerWidgetScreenState();
}

class _ConsumerWidgetScreenState extends ConsumerState<ConsumerWidgetScreen> {
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

    return Scaffold(
      appBar: AppBar(title: Text(l10n.consumerWidget)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.consumerWidgetBody),
            const SizedBox(height: 16),
            const Expanded(child: ConsumerWrapPanel()),
            const SizedBox(height: 12),
            const Expanded(child: ConsumerWidgetPanel()),
          ],
        ),
      ),
    );
  }
}
