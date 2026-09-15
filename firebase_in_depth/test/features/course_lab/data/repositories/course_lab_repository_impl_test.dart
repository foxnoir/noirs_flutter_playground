import 'package:firebase_in_depth/core/errors/app_exception.dart';
import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/course_lab/data/repositories/course_lab_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../course_fixtures.dart';
import '../../fake_course_lab_data_source.dart';

void main() {
  test('fetchCoursesByCategory maps matching models', () async {
    const repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(
        models: [
          sampleCourseModel,
          sampleAdvancedCourseModel,
          sampleExpertCourseModel,
        ],
      ),
    );

    expect(await repository.fetchCoursesByCategory('BEGINNER'), [sampleCourse]);
    expect(await repository.fetchCoursesByCategory('INTERMEDIATE'), [
      sampleAdvancedCourse,
    ]);
    expect(await repository.fetchCoursesByCategory('EXPERTS'), [
      sampleExpertCourse,
    ]);
    expect(await repository.fetchCoursesByCategory('ADVANCED'), isEmpty);
    expect(await repository.fetchCoursesByCategory('ADVANCE'), isEmpty);
  });

  test('maps a data-source exception to AppFailure', () async {
    const repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(error: NetworkException()),
    );

    await expectLater(
      repository.fetchCoursesByCategory('BEGINNER'),
      throwsA(const NetworkFailure()),
    );
  });
}
