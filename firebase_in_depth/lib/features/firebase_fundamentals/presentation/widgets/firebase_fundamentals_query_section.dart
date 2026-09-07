import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/course.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/providers/firebase_fundamentals_provider.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_async_result.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_compare_frame.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_course_list.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_hint_text.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_lab_button.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_wide_split.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseFundamentalsQuerySection extends ConsumerWidget {
  const FirebaseFundamentalsQuerySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(firebaseFundamentalsProvider);
    final notifier = ref.read(firebaseFundamentalsProvider.notifier);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.fundamentalsQueryTitle, style: textTheme.titleLarge),
        const SizedBox(height: 8),
        FirebaseFundamentalsHintText(text: l10n.fundamentalsQueryHint),
        const SizedBox(height: 12),
        FirebaseFundamentalsWideSplit(
          key: const Key('fundamentals-query-split'),
          left: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _QueryCard(
                valid: true,
                title: l10n.fundamentalsQueryValidTitle,
                hint: l10n.fundamentalsQueryValidHint,
                buttonKey: const Key('fundamentals-valid-query'),
                onPressed: notifier.runValidQuery,
                label: l10n.fundamentalsRunValidQuery,
                value: state.validQuery,
              ),
              const SizedBox(height: 12),
              _QueryCard(
                valid: true,
                title: l10n.fundamentalsQueryCompositeTitle,
                hint: l10n.fundamentalsQueryCompositeHint,
                buttonKey: const Key('fundamentals-composite-query'),
                onPressed: notifier.runCompositeQuery,
                label: l10n.fundamentalsRunCompositeQuery,
                value: state.compositeQuery,
              ),
            ],
          ),
          right: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _QueryCard(
                valid: false,
                title: l10n.fundamentalsQueryInvalidTitle,
                hint: l10n.fundamentalsQueryInvalidHint,
                buttonKey: const Key('fundamentals-invalid-query'),
                onPressed: notifier.runInvalidQuery,
                label: l10n.fundamentalsRunInvalidQuery,
                value: state.invalidQuery,
              ),
              const SizedBox(height: 12),
              _QueryCard(
                valid: false,
                title: l10n.fundamentalsQueryIndexTitle,
                hint: l10n.fundamentalsQueryIndexHint,
                buttonKey: const Key('fundamentals-missing-index-query'),
                onPressed: notifier.runMissingIndexQuery,
                label: l10n.fundamentalsRunIndexQuery,
                value: state.missingIndexQuery,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QueryCard extends StatelessWidget {
  const _QueryCard({
    required this.valid,
    required this.title,
    required this.hint,
    required this.buttonKey,
    required this.onPressed,
    required this.label,
    required this.value,
  });

  final bool valid;
  final String title;
  final String hint;
  final Key buttonKey;
  final VoidCallback onPressed;
  final String label;
  final AsyncValue<List<Course>>? value;

  @override
  Widget build(BuildContext context) {
    return FirebaseFundamentalsCompareFrame(
      valid: valid,
      title: title,
      hint: hint,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FirebaseFundamentalsLabButton(
            key: buttonKey,
            valid: valid,
            onPressed: onPressed,
            label: label,
          ),
          const SizedBox(height: 8),
          FirebaseFundamentalsAsyncResult<List<Course>>(
            value: value,
            idleLabel: AppLocalizations.of(context).fundamentalsIdle,
            data: (courses) => FirebaseFundamentalsCourseList(courses: courses),
          ),
        ],
      ),
    );
  }
}
