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
}
