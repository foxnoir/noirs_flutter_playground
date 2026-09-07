import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/lesson.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/providers/firebase_fundamentals_provider.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_async_result.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_compare_frame.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_lab_button.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_lesson_list.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_wide_split.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseFundamentalsLessonsLab extends ConsumerWidget {
  const FirebaseFundamentalsLessonsLab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(firebaseFundamentalsProvider);
    final notifier = ref.read(firebaseFundamentalsProvider.notifier);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.fundamentalsLessonsTitle, style: textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(l10n.fundamentalsLessonsHint, style: textTheme.bodySmall),
        const SizedBox(height: 12),
        FirebaseFundamentalsWideSplit(
          key: const Key('fundamentals-lessons-split'),
          left: _LessonCard(
            title: l10n.fundamentalsLessonsNestedTitle,
            hint: l10n.fundamentalsLessonsNestedHint,
            buttonKey: const Key('fundamentals-nested-lessons'),
            onPressed: notifier.readNestedLessons,
            label: l10n.fundamentalsReadNestedLessons,
            value: state.nestedLessons,
          ),
          right: _LessonCard(
            title: l10n.fundamentalsLessonsGroupTitle,
            hint: l10n.fundamentalsLessonsGroupHint,
            buttonKey: const Key('fundamentals-collection-group'),
            onPressed: notifier.runCollectionGroupQuery,
            label: l10n.fundamentalsRunCollectionGroup,
            value: state.collectionGroupLessons,
          ),
        ),
      ],
    );
  }
}

class _LessonCard extends StatelessWidget {
  const _LessonCard({
    required this.title,
    required this.hint,
    required this.buttonKey,
    required this.onPressed,
    required this.label,
    required this.value,
  });

  final String title;
  final String hint;
  final Key buttonKey;
  final VoidCallback onPressed;
  final String label;
  final AsyncValue<List<Lesson>>? value;

  @override
  Widget build(BuildContext context) {
    return FirebaseFundamentalsCompareFrame(
      valid: true,
      title: title,
      hint: hint,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FirebaseFundamentalsLabButton(
            key: buttonKey,
            valid: true,
            onPressed: onPressed,
            label: label,
          ),
          const SizedBox(height: 8),
          FirebaseFundamentalsAsyncResult<List<Lesson>>(
            value: value,
            idleLabel: AppLocalizations.of(context).fundamentalsIdle,
            data: (lessons) => FirebaseFundamentalsLessonList(lessons: lessons),
          ),
        ],
      ),
    );
  }
}
