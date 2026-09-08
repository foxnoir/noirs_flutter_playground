import 'package:firebase_in_depth/core/errors/app_exception.dart';
import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/course_lab/data/repositories/course_lab_repository_impl.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/courses_snapshot.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../course_fixtures.dart';
import '../../fake_course_lab_data_source.dart';

void main() {
  test('fetchCourse maps a model to an entity', () async {
    const repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(models: [sampleCourseModel]),
    );

    expect(await repository.fetchCourse(sampleCourse.id), sampleCourse);
  });

  test('fetchCourses maps models to entities', () async {
    const repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(models: [sampleCourseModel]),
    );

    expect(await repository.fetchCourses(), [sampleCourse]);
  });

  test('maps a data-source exception to AppFailure', () async {
    const repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(error: NetworkException()),
    );

    await expectLater(
      repository.fetchCourses(),
      throwsA(const NetworkFailure()),
    );
  });

  test('maps InvalidQueryException to InvalidQueryFailure', () async {
    const repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(
        invalidQueryError: InvalidQueryException('two inequalities'),
      ),
    );

    await expectLater(
      repository.fetchCoursesSeqNoAndLessonsCount(seqNo: 5, lessonsCount: 10),
      throwsA(const InvalidQueryFailure(detail: 'two inequalities')),
    );
  });

  test('maps a missing-index exception to InvalidQueryFailure', () async {
    const repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(
        missingIndexError: InvalidQueryException(
          'The query requires an index.',
        ),
      ),
    );

    await expectLater(
      repository.fetchCoursesSeqNoAndPrice(seqNo: 20, price: 15),
      throwsA(
        const InvalidQueryFailure(detail: 'The query requires an index.'),
      ),
    );
  });

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

  test('fetchLessonsCollectionGroup maps models to entities', () async {
    const repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(lessons: [sampleLessonModel]),
    );

    expect(await repository.fetchLessonsCollectionGroup(), [sampleLesson]);
  });

  test('fetchLessonsForCourse maps models to entities', () async {
    const repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(lessons: [sampleLessonModel]),
    );

    expect(await repository.fetchLessonsForCourse(sampleLesson.courseId), [
      sampleLesson,
    ]);
  });

  test('watchCourses maps a snapshot to entities', () async {
    const repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(models: [sampleCourseModel]),
    );

    expect(
      await repository.watchCourses().first,
      const CoursesSnapshot(
        courses: [sampleCourse],
        changes: [
          CourseChange(type: CourseChangeType.added, course: sampleCourse),
        ],
      ),
    );
  });

  test('watchCourses maps a data-source exception to AppFailure', () async {
    const repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(error: NetworkException()),
    );

    await expectLater(
      repository.watchCourses().first,
      throwsA(const NetworkFailure()),
    );
  });

  test('incrementParticipants maps an exception to AppFailure', () async {
    const repository = CourseLabRepositoryImpl(
      FakeCourseLabDataSource(error: NetworkException()),
    );

    await expectLater(
      repository.incrementParticipants(sampleCourse.id),
      throwsA(const NetworkFailure()),
    );
  });
}
