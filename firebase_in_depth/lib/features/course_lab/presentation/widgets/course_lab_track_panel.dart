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
  static const categoryIconSize = 72.0;

  final CourseLabTrack track;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final accent = track.tabAccent(theme);
    final courses = ref.watch(
      courseLabProvider.select(
        (state) => switch (track) {
          CourseLabTrack.beginner => state.beginner,
          CourseLabTrack.advanced => state.advanced,
          CourseLabTrack.expert => state.expert,
        },
      ),
    );
    final overlayAlign = track.overlayDragonAlign;

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
                    crossAxisAlignment: track.contentAlign,
                    children: [
                      Image.asset(
                        track.iconAsset,
                        key: Key('course-lab-icon-${track.name}'),
                        width: categoryIconSize,
                        height: categoryIconSize,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        track.headline(l10n),
                        textAlign: track.textAlign,
                        style: textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        track.body(l10n),
                        textAlign: track.textAlign,
                        style: textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: track == CourseLabTrack.advanced ? 8 : 20),
                      Expanded(
                        child: FirebaseFundamentalsAsyncResult<List<Course>>(
                          value: courses,
                          idleLabel: '',
                          data: (courses) => _TrackCourseList(
                            track: track,
                            courses: courses,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (overlayAlign != null)
                Align(
                  alignment: overlayAlign,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: _ScheduleDragon(
                      track: track,
                      widthFactor: 0.48,
                      mirrored: track.overlayDragonMirrored,
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

class _TrackCourseList extends StatelessWidget {
  const _TrackCourseList({required this.track, required this.courses});

  final CourseLabTrack track;
  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    final list = FirebaseFundamentalsCourseList(courses: courses);
    final body = KeyedSubtree(
      key: Key('course-lab-list-${track.name}'),
      child: track == CourseLabTrack.beginner
          ? list
          : IntrinsicWidth(child: list),
    );

    return SingleChildScrollView(
      child: Align(alignment: track.listAlign, child: body),
    );
  }
}

class _ScheduleDragon extends StatelessWidget {
  const _ScheduleDragon({
    required this.track,
    required this.widthFactor,
    this.mirrored = false,
  });

  final CourseLabTrack track;
  final double widthFactor;
  final bool mirrored;

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      CourseLabTrackPanel.scheduleDragonAsset,
      key: Key('schedule-dragon-${track.name}'),
      fit: BoxFit.contain,
    );
    if (mirrored) {
      image = Transform.flip(flipX: true, child: image);
    }

    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: ExcludeSemantics(
        child: IgnorePointer(child: image),
      ),
    );
  }
}
