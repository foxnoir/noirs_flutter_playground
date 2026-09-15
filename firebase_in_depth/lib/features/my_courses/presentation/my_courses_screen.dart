import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/core/errors/app_failure_message.dart';
import 'package:firebase_in_depth/core/router/app_router_names.dart';
import 'package:firebase_in_depth/core/theme/app_breakpoint.dart';
import 'package:firebase_in_depth/core/theme/app_color.dart';
import 'package:firebase_in_depth/features/auth/domain/entities/auth_session.dart';
import 'package:firebase_in_depth/features/auth/presentation/providers/auth_provider.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/widgets/course_lab_track_links.dart';
import 'package:firebase_in_depth/features/my_courses/presentation/providers/my_courses_provider.dart';
import 'package:firebase_in_depth/features/my_courses/presentation/widgets/my_course_card.dart';
import 'package:firebase_in_depth/features/my_courses/presentation/widgets/my_course_create_dialog.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:firebase_in_depth/shared_widgets/desktop_scaffold.dart';
import 'package:firebase_in_depth/shared_widgets/error_widget.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyCoursesScreen extends ConsumerWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final courses = ref.watch(myCoursesProvider);
    final isTutor = ref.watch(authProvider)?.role == AuthRole.tutor;

    return DesktopScaffold(
      currentRoute: AppRouteNames.myCourses,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.myCourses,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                if (isTutor)
                  IconButton.filled(
                    key: const Key('my-courses-create'),
                    tooltip: l10n.myCoursesCreate,
                    onPressed: () => showMyCourseCreateDialog(context),
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: AppColor.teal,
                    ),
                    icon: const Icon(Icons.add),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: switch (courses) {
                AsyncError(:final error) => app.ErrorWidget(
                  message: switch (AppFailure.from(error)) {
                    NetworkFailure() => l10n.courseLabLoadError,
                    final failure => failure.message(l10n),
                  },
                  retryLabel: l10n.retry,
                  onRetry: () {
                    ref.read(myCoursesProvider.notifier).reload();
                  },
                ),
                AsyncLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                AsyncData(:final value) when value.isEmpty => Center(
                  child: Text(
                    l10n.myCoursesEmpty,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                AsyncData(:final value) => _MyCoursesBoard(
                  courses: value,
                  isTutor: isTutor,
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MyCoursesBoard extends StatelessWidget {
  const _MyCoursesBoard({required this.courses, required this.isTutor});

  final List<Course> courses;
  final bool isTutor;

  @override
  Widget build(BuildContext context) {
    final grouped = {
      for (final track in CourseLabTrack.values)
        track: [
          for (final course in courses)
            if (CourseLabTrack.fromCategories(course.categories) == track)
              course,
        ],
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= AppBreakpoint.mediumMin;
        final beginner = grouped[CourseLabTrack.beginner] ?? const <Course>[];
        final advanced = grouped[CourseLabTrack.advanced] ?? const <Course>[];
        final expert = grouped[CourseLabTrack.expert] ?? const <Course>[];

        if (!wide) {
          return ListView(
            children: [
              for (final track in CourseLabTrack.values)
                _MyCoursesTrackColumn(
                  track: track,
                  courses: grouped[track] ?? const <Course>[],
                  isTutor: isTutor,
                ),
            ],
          );
        }

        return ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _MyCoursesTrackColumn(
                    track: CourseLabTrack.beginner,
                    courses: beginner,
                    isTutor: isTutor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _MyCoursesTrackColumn(
                    track: CourseLabTrack.advanced,
                    courses: advanced,
                    isTutor: isTutor,
                  ),
                ),
              ],
            ),
            if (expert.isNotEmpty)
              _MyCoursesTrackColumn(
                track: CourseLabTrack.expert,
                courses: expert,
                isTutor: isTutor,
              ),
          ],
        );
      },
    );
  }
}

class _MyCoursesTrackColumn extends ConsumerWidget {
  const _MyCoursesTrackColumn({
    required this.track,
    required this.courses,
    required this.isTutor,
  });

  final CourseLabTrack track;
  final List<Course> courses;
  final bool isTutor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        key: Key('my-courses-column-${track.name}'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            track.label(l10n),
            style: theme.textTheme.titleLarge?.copyWith(
              color: track.tabAccent(theme),
            ),
          ),
          const SizedBox(height: 12),
          for (final course in courses) ...[
            MyCourseCard(
              key: Key('my-course-card-${course.id}'),
              course: course,
              onEdit: isTutor
                  ? () {
                      // Edit stays visual until the next lab.
                    }
                  : null,
              onDelete: isTutor
                  ? () => _deleteCourse(context, ref, course.id)
                  : null,
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Future<void> _deleteCourse(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(myCoursesProvider.notifier).deleteCourse(id);
    } on Object catch (error) {
      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text(localizedError(l10n, error))),
      );
    }
  }
}
