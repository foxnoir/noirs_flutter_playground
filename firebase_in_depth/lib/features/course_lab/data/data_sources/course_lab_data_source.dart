import 'package:firebase_in_depth/features/course_lab/data/models/course_model.dart';

abstract interface class CourseLabDataSource {
  Future<List<CourseModel>> fetchCourses();

  Future<List<CourseModel>> fetchCoursesByCategory(String category);

  Future<CourseModel> createCourse(CourseModel course);

  Future<void> deleteCourse(String id);
}
