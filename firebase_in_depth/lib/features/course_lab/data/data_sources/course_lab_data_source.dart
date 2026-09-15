import 'package:firebase_in_depth/features/course_lab/data/models/course_model.dart';

// Catalog I/O is this one query today. Keep the contract as a data source.
// ignore: one_member_abstracts
abstract interface class CourseLabDataSource {
  Future<List<CourseModel>> fetchCoursesByCategory(String category);
}
