import 'package:firebase_in_depth/core/errors/app_exception.dart';
import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/data/repositories/firebase_fundamentals_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../course_fixtures.dart';
import '../../fake_firebase_fundamentals_data_source.dart';

void main() {
  test('fetchCourse maps a model to an entity', () async {
    const repository = FirebaseFundamentalsRepositoryImpl(
      FakeFirebaseFundamentalsDataSource(models: [sampleCourseModel]),
    );

    expect(await repository.fetchCourse(sampleCourse.id), sampleCourse);
  });

  test('fetchCourses maps models to entities', () async {
    const repository = FirebaseFundamentalsRepositoryImpl(
      FakeFirebaseFundamentalsDataSource(models: [sampleCourseModel]),
    );

    expect(await repository.fetchCourses(), [sampleCourse]);
  });

  test('maps a data-source exception to AppFailure', () async {
    const repository = FirebaseFundamentalsRepositoryImpl(
      FakeFirebaseFundamentalsDataSource(error: NetworkException()),
    );

    await expectLater(
      repository.fetchCourses(),
      throwsA(const NetworkFailure()),
    );
  });

  test('maps InvalidQueryException to InvalidQueryFailure', () async {
    const repository = FirebaseFundamentalsRepositoryImpl(
      FakeFirebaseFundamentalsDataSource(
        invalidQueryError: InvalidQueryException('two inequalities'),
      ),
    );

    await expectLater(
      repository.fetchCoursesSeqNoAndLessonsCount(seqNo: 5, lessonsCount: 10),
      throwsA(const InvalidQueryFailure(detail: 'two inequalities')),
    );
  });

  test('maps a missing-index exception to InvalidQueryFailure', () async {
    const repository = FirebaseFundamentalsRepositoryImpl(
      FakeFirebaseFundamentalsDataSource(
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

  test('fetchLessonsCollectionGroup maps models to entities', () async {
    const repository = FirebaseFundamentalsRepositoryImpl(
      FakeFirebaseFundamentalsDataSource(lessons: [sampleLessonModel]),
    );

    expect(await repository.fetchLessonsCollectionGroup(), [sampleLesson]);
  });

  test('fetchLessonsForCourse maps models to entities', () async {
    const repository = FirebaseFundamentalsRepositoryImpl(
      FakeFirebaseFundamentalsDataSource(lessons: [sampleLessonModel]),
    );

    expect(await repository.fetchLessonsForCourse(sampleLesson.courseId), [
      sampleLesson,
    ]);
  });
}
