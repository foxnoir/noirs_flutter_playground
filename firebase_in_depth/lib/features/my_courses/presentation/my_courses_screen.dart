import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/core/errors/app_failure_message.dart';
import 'package:firebase_in_depth/core/router/app_router_names.dart';
import 'package:firebase_in_depth/core/theme/app_breakpoint.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';
import 'package:firebase_in_depth/features/my_courses/presentation/providers/my_courses_provider.dart';
import 'package:firebase_in_depth/features/my_courses/presentation/widgets/my_course_card.dart';
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

    return DesktopScaffold(
      currentRoute: AppRouteNames.myCourses,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.myCourses,
              style: Theme.of(context).textTheme.displaySmall,
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
                AsyncData(:final value) => _MyCoursesGrid(courses: value),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MyCoursesGrid extends StatelessWidget {
  const _MyCoursesGrid({required this.courses});

  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= AppBreakpoint.mediumMin;
        if (!wide) {
          return ListView.separated(
            itemCount: courses.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return MyCourseCard(
                key: Key('my-course-card-${courses[index].id}'),
                course: courses[index],
              );
            },
          );
        }

        final rows = <List<Course>>[];
        for (var i = 0; i < courses.length; i += 2) {
          rows.add(
            courses.sublist(i, i + 2 > courses.length ? courses.length : i + 2),
          );
        }

        return ListView.separated(
          itemCount: rows.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final row = rows[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: MyCourseCard(
                    key: Key('my-course-card-${row[0].id}'),
                    course: row[0],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: row.length == 2
                      ? MyCourseCard(
                          key: Key('my-course-card-${row[1].id}'),
                          course: row[1],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
