import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';
import 'package:firebase_in_depth/features/course_lab/domain/repositories/course_lab_repository.dart';

class FakeCourseLabRepository implements CourseLabRepository {
  const FakeCourseLabRepository({this.courses = const [], this.error});

  final List<Course> courses;
  final AppFailure? error;

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
}
