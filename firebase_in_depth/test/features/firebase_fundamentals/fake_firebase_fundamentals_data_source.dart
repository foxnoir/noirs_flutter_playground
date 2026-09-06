import 'package:firebase_in_depth/core/errors/app_exception.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/data/data_sources/firebase_fundamentals_data_source.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/data/models/course_model.dart';

class FakeFirebaseFundamentalsDataSource
    implements FirebaseFundamentalsDataSource {
  const FakeFirebaseFundamentalsDataSource({
    this.models = const [],
    this.error,
    this.invalidQueryError,
    this.missingIndexError,
  });

  final List<CourseModel> models;
  final Exception? error;
  final Exception? invalidQueryError;
  final Exception? missingIndexError;

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
    final thrown = missingIndexError ?? error;
    if (thrown != null) throw thrown;
    return [
      for (final model in models)
        if (model.seqNo <= seqNo && model.url == url) model,
    ];
  }
}
