import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';

abstract interface class CourseLabRepository {
  Future<List<Course>> fetchCourses();

  Future<List<Course>> fetchCoursesByCategory(String category);

  Future<Course> createCourse({
    required String description,
    required String longDescription,
    required String category,
    required int seqNo,
  });

  Future<void> deleteCourse(String id);
}
