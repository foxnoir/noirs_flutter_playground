import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/course_lab/data/repositories/course_lab_repository_impl.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/tutor.dart';
import 'package:firebase_in_depth/features/course_lab/domain/repositories/course_lab_repository.dart';

class FakeCourseLabRepository implements CourseLabRepository {
  const FakeCourseLabRepository({
    this.courses = const [],
    this.error,
    this.deleteError,
    this.createError,
  });

  final List<Course> courses;
  final AppFailure? error;
  final AppFailure? deleteError;
  final AppFailure? createError;

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
  Future<Course> createCourse({
    required String description,
    required String longDescription,
    required String category,
    required int seqNo,
  }) async {
    final thrown = createError ?? error;
    if (thrown != null) throw thrown;
    final title = description.trim();
    final id = catalogCourseId(title, seqNo);
    final course = Course(
      id: id,
      description: title,
      longDescription: longDescription.trim(),
      url: id,
      seqNo: seqNo,
      lessonsCount: 0,
      price: 0,
      categories: [category],
      icon: 'purple',
      tutor: const Tutor(name: 'Noir', employedSince: [2020, 4, 1]),
    );
    courses.add(course);
    return course;
  }

  @override
  Future<void> deleteCourse(String id) async {
    final thrown = deleteError ?? error;
    if (thrown != null) throw thrown;
    courses.removeWhere((course) => course.id == id);
  }
}
