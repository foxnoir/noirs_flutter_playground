import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';
import 'package:firebase_in_depth/features/course_lab/domain/repositories/course_lab_repository.dart';

class FakeCourseLabRepository implements CourseLabRepository {
  const FakeCourseLabRepository({
    this.courses = const [],
    this.error,
    this.deleteError,
  });

  final List<Course> courses;
  final AppFailure? error;
  final AppFailure? deleteError;

  @override
  Future<List<Course>> fetchCourses() async {
    final thrown = error;
    if (thrown != null) throw thrown;
    return List<Course>.of(courses)..sort((a, b) => a.seqNo.compareTo(b.seqNo));
  }

  @override
  Future<List<Course>> fetchCoursesByCategory(String category) async {
    final thrown = error;
    if (thrown != null) throw thrown;
    return [
      for (final course in courses)
        if (course.categories.contains(category)) course,
    ]..sort((a, b) => a.seqNo.compareTo(b.seqNo));
  }

  @override
  Future<void> deleteCourse(String id) async {
    final thrown = deleteError ?? error;
    if (thrown != null) throw thrown;
    courses.removeWhere((course) => course.id == id);
  }
}
