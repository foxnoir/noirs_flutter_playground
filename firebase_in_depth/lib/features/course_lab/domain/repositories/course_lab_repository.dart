import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';

// Catalog API is this one query today. Keep the repository boundary.
// ignore: one_member_abstracts
abstract interface class CourseLabRepository {
  Future<List<Course>> fetchCoursesByCategory(String category);
}
