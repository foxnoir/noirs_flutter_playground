import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/providers/course_lab_provider.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/widgets/course_lab_track_links.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_async_result.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_course_list.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseLabTrackPanel extends ConsumerWidget {
  const CourseLabTrackPanel({required this.track, super.key});

  static const scheduleDragonAsset = 'assets/img/schedule_dragon.png';

  final CourseLabTrack track;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final beginner = track == CourseLabTrack.beginner;
    final accent = beginner ? scheme.primary : scheme.secondary;
    final onAccent = beginner ? scheme.onPrimary : scheme.onSecondary;
    final courses = ref.watch(
      courseLabProvider.select(
        (state) => beginner ? state.beginner : state.advanced,
      ),
    );

    final align = beginner ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final textAlign = beginner ? TextAlign.start : TextAlign.end;

    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surface.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: accent.withValues(alpha: 0.35)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                  child: Column(
                    crossAxisAlignment: align,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: accent,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            beginner
                                ? Icons.auto_stories_outlined
                                : Icons.school_outlined,
                            color: onAccent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        beginner
                            ? l10n.courseLabBeginnerHeadline
                            : l10n.courseLabAdvancedHeadline,
                        textAlign: textAlign,
                        style: textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        beginner
                            ? l10n.courseLabBeginnerBody
                            : l10n.courseLabAdvancedBody,
                        textAlign: textAlign,
                        style: textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: FirebaseFundamentalsAsyncResult<List<Course>>(
                          value: courses,
                          idleLabel: '',
                          data: (courses) {
                            final list = FirebaseFundamentalsCourseList(
                              courses: courses,
                            );
                            return SingleChildScrollView(
                              child: Align(
                                alignment: beginner
                                    ? Alignment.topLeft
                                    : Alignment.topRight,
                                child: beginner
                                    ? list
                                    : IntrinsicWidth(child: list),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: beginner
                    ? Alignment.bottomRight
                    : Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: FractionallySizedBox(
                    widthFactor: 0.48,
                    child: ExcludeSemantics(
                      child: IgnorePointer(
                        child: Image.asset(
                          scheduleDragonAsset,
                          key: Key('schedule-dragon-${track.name}'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
