import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/course.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/lesson.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/domain/repositories/firebase_fundamentals_repository.dart';

class FakeFirebaseFundamentalsRepository
    implements FirebaseFundamentalsRepository {
  const FakeFirebaseFundamentalsRepository({
    this.course,
    this.courses = const [],
    this.error,
    this.invalidQueryError,
    this.missingIndexError,
    this.lessons = const [],
  });

  final Course? course;
  final List<Course> courses;
  final AppFailure? error;
  final AppFailure? invalidQueryError;
  final AppFailure? missingIndexError;
  final List<Lesson> lessons;

  @override
  Future<Course> fetchCourse(String id) async {
    final thrown = error;
    if (thrown != null) throw thrown;
    final course = this.course;
    if (course == null || course.id != id) {
      throw const NotFoundFailure();
    }
    return course;
  }

  @override
  Future<List<Course>> fetchCourses() async {
    final thrown = error;
    if (thrown != null) throw thrown;
    return courses;
  }

  @override
  Future<List<Course>> fetchCoursesSeqNoAtMost(int seqNo) async {
    final thrown = error;
    if (thrown != null) throw thrown;
    return [
      for (final course in courses)
        if (course.seqNo <= seqNo) course,
    ];
  }

  @override
  Future<List<Course>> fetchCoursesSeqNoAndLessonsCount({
    required int seqNo,
    required int lessonsCount,
  }) async {
    final thrown = invalidQueryError ?? error;
    if (thrown != null) throw thrown;
    return [
      for (final course in courses)
        if (course.seqNo <= seqNo && course.lessonsCount <= lessonsCount)
          course,
    ];
  }

  @override
  Future<List<Course>> fetchCoursesSeqNoAndUrl({
    required int seqNo,
    required String url,
  }) async {
    final thrown = error;
    if (thrown != null) throw thrown;
    return [
      for (final course in courses)
        if (course.seqNo <= seqNo && course.url == url) course,
    ];
  }

  @override
  Future<List<Course>> fetchCoursesSeqNoAndPrice({
    required int seqNo,
    required int price,
  }) async {
    final thrown = missingIndexError ?? error;
    if (thrown != null) throw thrown;
    return [
      for (final course in courses)
        if (course.seqNo <= seqNo && course.price == price) course,
    ];
  }

  @override
  Future<List<Lesson>> fetchLessonsForCourse(String courseId) async {
    final thrown = error;
    if (thrown != null) throw thrown;
    return [
      for (final lesson in lessons)
        if (lesson.courseId == courseId) lesson,
    ];
  }

  @override
  Future<List<Lesson>> fetchLessonsCollectionGroup() async {
    final thrown = error;
    if (thrown != null) throw thrown;
    return lessons;
  }
}
