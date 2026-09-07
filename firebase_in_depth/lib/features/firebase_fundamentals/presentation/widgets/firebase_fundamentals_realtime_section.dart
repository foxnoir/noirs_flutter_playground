import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/courses_snapshot.dart';
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

class FirebaseFundamentalsRealtimeSection extends ConsumerWidget {
  const FirebaseFundamentalsRealtimeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(firebaseFundamentalsProvider);
    final notifier = ref.read(firebaseFundamentalsProvider.notifier);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.fundamentalsRealtimeTitle, style: textTheme.titleLarge),
        const SizedBox(height: 8),
        FirebaseFundamentalsHintText(text: l10n.fundamentalsRealtimeHint),
        const SizedBox(height: 12),
        FirebaseFundamentalsWideSplit(
          key: const Key('fundamentals-realtime-split'),
          left: FirebaseFundamentalsCompareFrame(
            valid: true,
            title: l10n.fundamentalsRealtimeListenTitle,
            hint: l10n.fundamentalsRealtimeListenHint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FirebaseFundamentalsLabButton(
                      key: const Key('fundamentals-realtime-listen'),
                      valid: true,
                      onPressed: notifier.startRealtime,
                      label: l10n.fundamentalsRealtimeListen,
                    ),
                    FirebaseFundamentalsLabButton(
                      key: const Key('fundamentals-realtime-stop'),
                      valid: true,
                      onPressed: state.listening ? notifier.stopRealtime : null,
                      label: l10n.fundamentalsRealtimeStop,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                FirebaseFundamentalsAsyncResult<CoursesSnapshot>(
                  value: state.realtime,
                  idleLabel: l10n.fundamentalsRealtimeIdle,
                  data: (snapshot) => FirebaseFundamentalsCourseList(
                    courses: snapshot.courses,
                    showParticipants: true,
                  ),
                ),
              ],
            ),
          ),
          right: FirebaseFundamentalsCompareFrame(
            valid: true,
            title: l10n.fundamentalsRealtimeChangesTitle,
            hint: l10n.fundamentalsRealtimeChangesHint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FirebaseFundamentalsLabButton(
                  key: const Key('fundamentals-realtime-increment'),
                  valid: true,
                  onPressed: notifier.incrementParticipants,
                  label: l10n.fundamentalsRealtimeIncrement,
                ),
                const SizedBox(height: 8),
                FirebaseFundamentalsAsyncResult<void>(
                  value: state.increment,
                  idleLabel: l10n.fundamentalsRealtimeIncrementIdle,
                  data: (_) => const SizedBox.shrink(),
                ),
                FirebaseFundamentalsAsyncResult<CoursesSnapshot>(
                  value: state.realtime,
                  idleLabel: l10n.fundamentalsRealtimeChangesIdle,
                  data: (snapshot) => _ChangeList(changes: snapshot.changes),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ChangeList extends StatelessWidget {
  const _ChangeList({required this.changes});

  final List<CourseChange> changes;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (changes.isEmpty) {
      return Text(
        l10n.fundamentalsEmpty,
        style: Theme.of(context).textTheme.bodySmall,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final change in changes)
          Text(
            l10n.fundamentalsRealtimeChange(
              _typeLabel(l10n, change.type),
              change.course.description,
              change.course.participants,
            ),
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }

  String _typeLabel(AppLocalizations l10n, CourseChangeType type) {
    return switch (type) {
      CourseChangeType.added => l10n.fundamentalsChangeAdded,
      CourseChangeType.modified => l10n.fundamentalsChangeModified,
      CourseChangeType.removed => l10n.fundamentalsChangeRemoved,
    };
  }
}
