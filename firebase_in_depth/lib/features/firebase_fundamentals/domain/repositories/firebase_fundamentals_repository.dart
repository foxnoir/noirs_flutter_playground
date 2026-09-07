import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/course.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/courses_snapshot.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/lesson.dart';

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

  Future<List<Lesson>> fetchLessonsForCourse(String courseId);

  Future<List<Lesson>> fetchLessonsCollectionGroup();

  Stream<CoursesSnapshot> watchCourses();

  Future<void> incrementParticipants(String courseId);
}
