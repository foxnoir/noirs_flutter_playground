import 'package:firebase_in_depth/core/errors/app_exception.dart';
import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/course_lab/data/data_sources/course_lab_data_source.dart';
import 'package:firebase_in_depth/features/course_lab/data/data_sources/course_lab_data_source_impl.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/course_model.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';
import 'package:firebase_in_depth/features/course_lab/domain/repositories/course_lab_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final courseLabRepositoryProvider = Provider<CourseLabRepository>((ref) {
  return CourseLabRepositoryImpl(ref.watch(courseLabDataSourceProvider));
});

class CourseLabRepositoryImpl implements CourseLabRepository {
  const CourseLabRepositoryImpl(this._dataSource);

  final CourseLabDataSource _dataSource;

  @override
  Future<List<Course>> fetchCourses() {
    return _map(_dataSource.fetchCourses);
  }

  @override
  Future<List<Course>> fetchCoursesByCategory(String category) {
    return _map(() => _dataSource.fetchCoursesByCategory(category));
  }

  Future<List<Course>> _map(Future<List<CourseModel>> Function() run) async {
    try {
      final models = await run();
      return [for (final model in models) model.toEntity()];
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }
}
