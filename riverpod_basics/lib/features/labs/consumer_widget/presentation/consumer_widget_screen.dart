import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/consumer_widget/presentation/widgets/consumer_widget_panel.dart';
import 'package:riverpod_basics/features/labs/consumer_widget/presentation/widgets/consumer_wrap_panel.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/lab_intro_copy.dart';

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final panelHeight = (constraints.maxHeight * 0.36).clamp(
            200.0,
            360.0,
          );
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              LabIntroCopy(l10n.consumerWidgetBody),
              const SizedBox(height: 16),
              SizedBox(height: panelHeight, child: const ConsumerWrapPanel()),
              const SizedBox(height: 12),
              SizedBox(height: panelHeight, child: const ConsumerWidgetPanel()),
            ],
          );
        },
      ),
    );
  }
}
