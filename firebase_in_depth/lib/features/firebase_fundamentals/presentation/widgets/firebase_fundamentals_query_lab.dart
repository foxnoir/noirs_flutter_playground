import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/course.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/providers/firebase_fundamentals_provider.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_async_result.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_compare_frame.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_course_list.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseFundamentalsQueryLab extends ConsumerWidget {
  const FirebaseFundamentalsQueryLab({super.key});

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
        Text(l10n.fundamentalsQueryHint, style: textTheme.bodySmall),
        const SizedBox(height: 12),
        FirebaseFundamentalsCompareFrame(
          valid: true,
          title: l10n.fundamentalsQueryValidTitle,
          hint: l10n.fundamentalsQueryValidHint,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                key: const Key('fundamentals-valid-query'),
                onPressed: notifier.runValidQuery,
                child: Text(l10n.fundamentalsRunValidQuery),
              ),
              const SizedBox(height: 8),
              FirebaseFundamentalsAsyncResult<List<Course>>(
                value: state.validQuery,
                idleLabel: l10n.fundamentalsIdle,
                data: (courses) =>
                    FirebaseFundamentalsCourseList(courses: courses),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        FirebaseFundamentalsCompareFrame(
          valid: false,
          title: l10n.fundamentalsQueryInvalidTitle,
          hint: l10n.fundamentalsQueryInvalidHint,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                key: const Key('fundamentals-invalid-query'),
                onPressed: notifier.runInvalidQuery,
                child: Text(l10n.fundamentalsRunInvalidQuery),
              ),
              const SizedBox(height: 8),
              FirebaseFundamentalsAsyncResult<List<Course>>(
                value: state.invalidQuery,
                idleLabel: l10n.fundamentalsIdle,
                data: (courses) =>
                    FirebaseFundamentalsCourseList(courses: courses),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        FirebaseFundamentalsCompareFrame(
          valid: false,
          title: l10n.fundamentalsQueryIndexTitle,
          hint: l10n.fundamentalsQueryIndexHint,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                key: const Key('fundamentals-missing-index-query'),
                onPressed: notifier.runMissingIndexQuery,
                child: Text(l10n.fundamentalsRunIndexQuery),
              ),
              const SizedBox(height: 8),
              FirebaseFundamentalsAsyncResult<List<Course>>(
                value: state.missingIndexQuery,
                idleLabel: l10n.fundamentalsIdle,
                data: (courses) =>
                    FirebaseFundamentalsCourseList(courses: courses),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
