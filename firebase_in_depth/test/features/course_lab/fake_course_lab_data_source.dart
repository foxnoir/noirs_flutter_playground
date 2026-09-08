import 'package:firebase_in_depth/core/errors/app_exception.dart';
import 'package:firebase_in_depth/features/course_lab/data/data_sources/course_lab_data_source.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/course_model.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/courses_snapshot_model.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/lesson_model.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/courses_snapshot.dart';

class FakeCourseLabDataSource implements CourseLabDataSource {
  const FakeCourseLabDataSource({
    this.models = const [],
    this.error,
    this.invalidQueryError,
    this.missingIndexError,
    this.lessons = const [],
  });

  final List<CourseModel> models;
  final Exception? error;
  final Exception? invalidQueryError;
  final Exception? missingIndexError;
  final List<LessonModel> lessons;

  @override
  Future<CourseModel> fetchCourse(String id) async {
    final thrown = error;
    if (thrown != null) throw thrown;
    for (final model in models) {
      if (model.id == id) return model;
    }
    throw const NotFoundException();
  }

  @override
  Future<List<CourseModel>> fetchCourses() async {
    final thrown = error;
    if (thrown != null) throw thrown;
    return models;
  }

  @override
  Future<List<CourseModel>> fetchCoursesSeqNoAtMost(int seqNo) async {
    final thrown = error;
    if (thrown != null) throw thrown;
    return [
      for (final model in models)
        if (model.seqNo <= seqNo) model,
    ];
  }

  @override
  Future<List<CourseModel>> fetchCoursesSeqNoAndLessonsCount({
    required int seqNo,
    required int lessonsCount,
  }) async {
    final thrown = invalidQueryError ?? error;
    if (thrown != null) throw thrown;
    return [
      for (final model in models)
        if (model.seqNo <= seqNo && model.lessonsCount <= lessonsCount) model,
    ];
  }

  @override
  Future<List<CourseModel>> fetchCoursesSeqNoAndUrl({
    required int seqNo,
    required String url,
  }) async {
    final thrown = error;
    if (thrown != null) throw thrown;
    return [
      for (final model in models)
        if (model.seqNo <= seqNo && model.url == url) model,
    ];
  }

  @override
  Future<List<CourseModel>> fetchCoursesSeqNoAndPrice({
    required int seqNo,
    required int price,
  }) async {
    final thrown = missingIndexError ?? error;
    if (thrown != null) throw thrown;
    return [
      for (final model in models)
        if (model.seqNo <= seqNo && model.price == price) model,
    ];
  }

  @override
  Future<List<LessonModel>> fetchLessonsForCourse(String courseId) async {
    final thrown = error;
    if (thrown != null) throw thrown;
    return [
      for (final lesson in lessons)
        if (lesson.courseId == courseId) lesson,
    ];
  }

  @override
  Future<List<LessonModel>> fetchLessonsCollectionGroup() async {
    final thrown = error;
    if (thrown != null) throw thrown;
    return lessons;
  }

  @override
  Future<List<CourseModel>> fetchCoursesByCategory(String category) async {
    final thrown = error;
    if (thrown != null) throw thrown;
    return [
      for (final model in models)
        if (model.categories.contains(category)) model,
    ]..sort((a, b) => a.seqNo.compareTo(b.seqNo));
  }

  @override
  Stream<CoursesSnapshotModel> watchCourses() {
    final thrown = error;
    if (thrown != null) return Stream.error(thrown);
    return Stream.value(
      CoursesSnapshotModel(
        courses: models,
        changes: [
          for (final model in models)
            CourseChangeModel(type: CourseChangeType.added, course: model),
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
