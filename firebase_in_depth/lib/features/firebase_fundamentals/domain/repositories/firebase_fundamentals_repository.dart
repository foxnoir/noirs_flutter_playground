import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/course.dart';

abstract interface class FirebaseFundamentalsRepository {
  Future<Course> fetchCourse(String id);

  Future<List<Course>> fetchCourses();

  Future<List<Course>> fetchCoursesSeqNoAtMost(int seqNo);

  Future<List<Course>> fetchCoursesSeqNoAndLessonsCount({
    required int seqNo,
    required int lessonsCount,
  });

  Future<List<Course>> fetchCoursesSeqNoAndUrl({
    required int seqNo,
    required String url,
  });

  Future<List<Course>> fetchCoursesSeqNoAndPrice({
    required int seqNo,
    required int price,
  });
}
