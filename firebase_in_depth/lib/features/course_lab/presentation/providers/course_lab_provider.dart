import 'dart:async';

import 'package:firebase_in_depth/features/course_lab/data/repositories/course_lab_repository_impl.dart';
import 'package:firebase_in_depth/features/course_lab/domain/repositories/course_lab_repository.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/providers/course_lab_state.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/widgets/course_lab_track_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final courseLabProvider =
    NotifierProvider.autoDispose<CourseLabNotifier, CourseLabState>(
      CourseLabNotifier.new,
    );

class CourseLabNotifier extends Notifier<CourseLabState> {
  @override
  CourseLabState build() {
    unawaited(reload());
    return const CourseLabState(
      beginner: AsyncLoading(),
      advanced: AsyncLoading(),
    );
  }

  CourseLabRepository get _repository {
    return ref.read(courseLabRepositoryProvider);
  }

  Future<void> reload() async {
    final repository = _repository;
    final beginnerFuture = AsyncValue.guard(
      () => repository.fetchCoursesByCategory(CourseLabTrack.beginner.category),
    );
    final advancedFuture = AsyncValue.guard(
      () => repository.fetchCoursesByCategory(CourseLabTrack.advanced.category),
    );
    final beginner = await beginnerFuture;
    final advanced = await advancedFuture;
    if (!ref.mounted) return;
    state = CourseLabState(beginner: beginner, advanced: advanced);
  }
}
