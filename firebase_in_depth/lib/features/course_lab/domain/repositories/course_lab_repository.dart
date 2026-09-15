import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';

abstract interface class CourseLabRepository {
  Future<List<Course>> fetchCourses();

  Future<List<Course>> fetchCoursesByCategory(String category);
}
