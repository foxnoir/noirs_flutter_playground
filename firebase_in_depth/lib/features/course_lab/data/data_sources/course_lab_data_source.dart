import 'package:firebase_in_depth/features/course_lab/data/models/course_model.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/courses_snapshot_model.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/lesson_model.dart';

abstract interface class CourseLabDataSource {
  Future<CourseModel> fetchCourse(String id);

  Future<List<CourseModel>> fetchCourses();

  Future<List<CourseModel>> fetchCoursesSeqNoAtMost(int seqNo);

  Future<List<CourseModel>> fetchCoursesSeqNoAndLessonsCount({
    required int seqNo,
    required int lessonsCount,
  });

  Future<List<CourseModel>> fetchCoursesSeqNoAndUrl({
    required int seqNo,
    required String url,
  });

  Future<List<CourseModel>> fetchCoursesSeqNoAndPrice({
    required int seqNo,
    required int price,
  });

  Future<List<LessonModel>> fetchLessonsForCourse(String courseId);

  Future<List<LessonModel>> fetchLessonsCollectionGroup();

  Future<List<CourseModel>> fetchCoursesByCategory(String category);

  Stream<CoursesSnapshotModel> watchCourses();

  Future<void> incrementParticipants(String courseId);
}
