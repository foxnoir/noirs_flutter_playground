import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/courses_snapshot.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/lesson.dart';
import 'package:firebase_in_depth/features/course_lab/domain/repositories/course_lab_repository.dart';

class FakeCourseLabRepository implements CourseLabRepository {
  const FakeCourseLabRepository({
    this.course,
    this.courses = const [],
    this.error,
    this.invalidQueryError,
    this.missingIndexError,
    this.lessons = const [],
    this.realtime,
  });

  final Course? course;
  final List<Course> courses;
  final AppFailure? error;
  final AppFailure? invalidQueryError;
  final AppFailure? missingIndexError;
  final List<Lesson> lessons;
  final Stream<CoursesSnapshot>? realtime;

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
  Stream<CoursesSnapshot> watchCourses() {
    final thrown = error;
    if (thrown != null) return Stream.error(thrown);
    final realtime = this.realtime;
    if (realtime != null) return realtime;
    return Stream.value(
      CoursesSnapshot(
        courses: courses,
        changes: [
          for (final course in courses)
            CourseChange(type: CourseChangeType.added, course: course),
        ],
      ),
    );
  }

  @override
  Future<void> incrementParticipants(String courseId) async {
    final thrown = error;
    if (thrown != null) throw thrown;
  }
}
