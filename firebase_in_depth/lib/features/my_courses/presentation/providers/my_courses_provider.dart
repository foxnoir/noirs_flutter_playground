import 'dart:async';

import 'package:firebase_in_depth/features/course_lab/data/repositories/course_lab_repository_impl.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myCoursesProvider =
    NotifierProvider.autoDispose<MyCoursesNotifier, AsyncValue<List<Course>>>(
      MyCoursesNotifier.new,
    );

class MyCoursesNotifier extends Notifier<AsyncValue<List<Course>>> {
  @override
  AsyncValue<List<Course>> build() {
    unawaited(reload());
    return const AsyncLoading();
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    final next = await AsyncValue.guard(
      () => ref.read(courseLabRepositoryProvider).fetchCourses(),
    );
    if (!ref.mounted) return;
    state = next;
  }

  Future<void> deleteCourse(String id) async {
    await ref.read(courseLabRepositoryProvider).deleteCourse(id);
    if (!ref.mounted) return;
    final current = state.value;
    if (current == null) {
      await reload();
      return;
    }
    state = AsyncData([
      for (final course in current)
        if (course.id != id) course,
    ]);
  }
}
