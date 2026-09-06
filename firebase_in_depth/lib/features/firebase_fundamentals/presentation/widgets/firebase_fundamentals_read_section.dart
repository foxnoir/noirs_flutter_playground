import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/course.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/providers/firebase_fundamentals_provider.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_async_result.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_course_list.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_course_tile.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseFundamentalsReadSection extends ConsumerWidget {
  const FirebaseFundamentalsReadSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(firebaseFundamentalsProvider);
    final notifier = ref.read(firebaseFundamentalsProvider.notifier);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.fundamentalsReadTitle, style: textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(l10n.fundamentalsReadHint, style: textTheme.bodySmall),
        const SizedBox(height: 12),
        FilledButton(
          key: const Key('fundamentals-read-document'),
          onPressed: notifier.readDocument,
          child: Text(l10n.fundamentalsReadDocument),
        ),
        const SizedBox(height: 8),
        FirebaseFundamentalsAsyncResult<Course>(
          value: state.document,
          idleLabel: l10n.fundamentalsIdle,
          data: (course) => FirebaseFundamentalsCourseTile(course: course),
        ),
        const SizedBox(height: 16),
        FilledButton.tonal(
          key: const Key('fundamentals-read-collection'),
          onPressed: notifier.readCollection,
          child: Text(l10n.fundamentalsReadCollection),
        ),
        const SizedBox(height: 8),
        FirebaseFundamentalsAsyncResult<List<Course>>(
          value: state.collection,
          idleLabel: l10n.fundamentalsIdle,
          data: (courses) => FirebaseFundamentalsCourseList(courses: courses),
        ),
      ],
    );
  }
}
