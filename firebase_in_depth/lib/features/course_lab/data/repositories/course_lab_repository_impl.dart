import 'package:firebase_in_depth/core/errors/app_exception.dart';
import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/course_lab/data/data_sources/course_lab_data_source.dart';
import 'package:firebase_in_depth/features/course_lab/data/data_sources/course_lab_data_source_impl.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/course_model.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/tutor_model.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';
import 'package:firebase_in_depth/features/course_lab/domain/repositories/course_lab_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final courseLabRepositoryProvider = Provider<CourseLabRepository>((ref) {
  return CourseLabRepositoryImpl(ref.watch(courseLabDataSourceProvider));
});

class CourseLabRepositoryImpl implements CourseLabRepository {
  const CourseLabRepositoryImpl(this._dataSource);

  static const _catalogTutor = TutorModel(
    name: 'Noir',
    employedSince: [2020, 4, 1],
  );

  final CourseLabDataSource _dataSource;

  @override
  Future<List<Course>> fetchCourses() {
    return _map(_dataSource.fetchCourses);
  }

  @override
  Future<List<Course>> fetchCoursesByCategory(String category) {
    return _map(() => _dataSource.fetchCoursesByCategory(category));
  }

  @override
  Future<Course> createCourse({
    required String description,
    required String longDescription,
    required String category,
    required int seqNo,
  }) async {
    final title = description.trim();
    final id = catalogCourseId(title, seqNo);
    try {
      final model = await _dataSource.createCourse(
        CourseModel(
          id: id,
          description: title,
          longDescription: longDescription.trim(),
          url: id,
          seqNo: seqNo,
          lessonsCount: 0,
          price: 0,
          categories: [category],
          icon: _iconFor(category),
          tutor: _catalogTutor,
        ),
      );
      return model.toEntity();
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  @override
  Future<void> deleteCourse(String id) {
    return _run(() => _dataSource.deleteCourse(id));
  }

  Future<void> _run(Future<void> Function() run) async {
    try {
      await run();
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  Future<List<Course>> _map(Future<List<CourseModel>> Function() run) async {
    try {
      final models = await run();
      return [for (final model in models) model.toEntity()];
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  static String _iconFor(String category) {
    return switch (category) {
      'INTERMEDIATE' => 'green',
      'EXPERTS' => 'turquoise',
      _ => 'purple',
    };
  }
}

String catalogCourseId(String description, int seqNo) {
  final slug = description
      .trim()
      .toLowerCase()
      .replaceAll(RegExp('[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
  if (slug.isEmpty) return 'course-$seqNo';
  return slug;
}
