import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/providers/firebase_fundamentals_provider.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_async_result.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_compare_frame.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_hint_text.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_lab_button.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseFundamentalsRulesSection extends ConsumerWidget {
  const FirebaseFundamentalsRulesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(firebaseFundamentalsProvider);
    final notifier = ref.read(firebaseFundamentalsProvider.notifier);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.fundamentalsRulesTitle, style: textTheme.titleLarge),
        const SizedBox(height: 8),
        FirebaseFundamentalsHintText(text: l10n.fundamentalsRulesHint),
        const SizedBox(height: 12),
        FirebaseFundamentalsCompareFrame(
          valid: false,
          title: l10n.fundamentalsRulesDeniedTitle,
          hint: l10n.fundamentalsRulesDeniedHint,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FirebaseFundamentalsLabButton(
                key: const Key('fundamentals-denied-read'),
                valid: false,
                onPressed: notifier.runDeniedRead,
                label: l10n.fundamentalsRunDeniedRead,
              ),
              const SizedBox(height: 8),
              FirebaseFundamentalsAsyncResult<void>(
                value: state.deniedRead,
                idleLabel: l10n.fundamentalsIdle,
                data: (_) => Text(
                  l10n.fundamentalsDeniedUnexpected,
                  style: textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
