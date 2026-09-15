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

  test('fetchCourses returns the catalog sorted by seqNo', () async {
    const repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(
        models: [
          sampleExpertCourseModel,
          sampleCourseModel,
          sampleAdvancedCourseModel,
        ],
      ),
    );

    expect(await repository.fetchCourses(), [
      sampleCourse,
      sampleAdvancedCourse,
      sampleExpertCourse,
    ]);
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

  test('deleteCourse removes the document from the catalog', () async {
    final repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(
        models: List.of([sampleCourseModel, sampleAdvancedCourseModel]),
      ),
    );

    await repository.deleteCourse(sampleCourse.id);

    expect(await repository.fetchCourses(), [sampleAdvancedCourse]);
  });

  test('deleteCourse maps a permission exception', () async {
    const repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(error: PermissionException()),
    );

    await expectLater(
      repository.deleteCourse(sampleCourse.id),
      throwsA(const PermissionFailure()),
    );
  });

  test('createCourse writes a catalog-shaped document', () async {
    final repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(models: List.of([sampleCourseModel])),
    );

    final created = await repository.createCourse(
      description: 'Night School',
      longDescription: 'Evenings only.',
      category: 'BEGINNER',
      seqNo: 12,
    );

    expect(created.id, 'night-school');
    expect(created.url, 'night-school');
    expect(created.seqNo, 12);
    expect(created.categories, ['BEGINNER']);
    expect(created.lessonsCount, 0);
    expect(await repository.fetchCourses(), [sampleCourse, created]);
  });

  test('createCourse maps a permission exception', () async {
    const repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(error: PermissionException()),
    );

    await expectLater(
      repository.createCourse(
        description: 'Night School',
        longDescription: 'Evenings only.',
        category: 'BEGINNER',
        seqNo: 12,
      ),
      throwsA(const PermissionFailure()),
    );
  });

  test('catalogCourseId slugs the title', () {
    expect(catalogCourseId('Night School', 12), 'night-school');
    expect(catalogCourseId('   ', 12), 'course-12');
  });
}
