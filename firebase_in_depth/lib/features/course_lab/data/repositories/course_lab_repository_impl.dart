import 'package:firebase_in_depth/core/errors/app_exception.dart';
import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/course_lab/data/data_sources/course_lab_data_source.dart';
import 'package:firebase_in_depth/features/course_lab/data/data_sources/course_lab_data_source_impl.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/course_model.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/lesson_model.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/courses_snapshot.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/lesson.dart';
import 'package:firebase_in_depth/features/course_lab/domain/repositories/course_lab_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final courseLabRepositoryProvider = Provider<CourseLabRepository>((ref) {
  return CourseLabRepositoryImpl(ref.watch(courseLabDataSourceProvider));
});

class CourseLabRepositoryImpl implements CourseLabRepository {
  const CourseLabRepositoryImpl(this._dataSource);

  final CourseLabDataSource _dataSource;

  @override
  Future<Course> fetchCourse(String id) {
    return _map(() => _dataSource.fetchCourse(id));
  }

  @override
  Future<List<Course>> fetchCourses() {
    return _mapList(_dataSource.fetchCourses);
  }

  @override
  Future<List<Course>> fetchCoursesSeqNoAtMost(int seqNo) {
    return _mapList(() => _dataSource.fetchCoursesSeqNoAtMost(seqNo));
  }

  @override
  Future<List<Course>> fetchCoursesSeqNoAndLessonsCount({
    required int seqNo,
    required int lessonsCount,
  }) {
    return _mapList(
      () => _dataSource.fetchCoursesSeqNoAndLessonsCount(
        seqNo: seqNo,
        lessonsCount: lessonsCount,
      ),
    );
  }

  @override
  Future<List<Course>> fetchCoursesSeqNoAndUrl({
    required int seqNo,
    required String url,
  }) {
    return _mapList(
      () => _dataSource.fetchCoursesSeqNoAndUrl(seqNo: seqNo, url: url),
    );
  }

  @override
  Future<List<Course>> fetchCoursesSeqNoAndPrice({
    required int seqNo,
    required int price,
  }) {
    return _mapList(
      () => _dataSource.fetchCoursesSeqNoAndPrice(seqNo: seqNo, price: price),
    );
  }

  @override
  Future<List<Lesson>> fetchLessonsForCourse(String courseId) {
    return _mapLessonList(() => _dataSource.fetchLessonsForCourse(courseId));
  }

  @override
  Future<List<Lesson>> fetchLessonsCollectionGroup() {
    return _mapLessonList(_dataSource.fetchLessonsCollectionGroup);
  }

  @override
  Future<List<Course>> fetchCoursesByCategory(String category) {
    return _mapList(() => _dataSource.fetchCoursesByCategory(category));
  }

  @override
  Stream<CoursesSnapshot> watchCourses() {
    return _dataSource
        .watchCourses()
        .map((model) => model.toEntity())
        .handleError((Object error, StackTrace stack) {
          Error.throwWithStackTrace(
            error is AppException ? AppFailure.fromException(error) : error,
            stack,
          );
        });
  }

  @override
  Future<void> incrementParticipants(String courseId) {
    return _mapVoid(() => _dataSource.incrementParticipants(courseId));
  }

  Future<Course> _map(Future<CourseModel> Function() run) async {
    try {
      final model = await run();
      return model.toEntity();
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  Future<List<Course>> _mapList(
    Future<List<CourseModel>> Function() run,
  ) async {
    try {
      final models = await run();
      return [for (final model in models) model.toEntity()];
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  Future<List<Lesson>> _mapLessonList(
    Future<List<LessonModel>> Function() run,
  ) async {
    try {
      final models = await run();
      return [for (final model in models) model.toEntity()];
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  Future<void> _mapVoid(Future<void> Function() run) async {
    try {
      await run();
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }
}
