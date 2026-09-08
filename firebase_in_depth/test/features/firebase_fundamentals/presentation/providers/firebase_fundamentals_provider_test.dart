import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/course_lab/data/repositories/course_lab_repository_impl.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/providers/firebase_fundamentals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../course_lab/course_fixtures.dart';
import '../../../course_lab/fake_course_lab_repository.dart';

void main() {
  ProviderContainer containerWith(FakeCourseLabRepository repository) {
    final container = ProviderContainer.test(
      overrides: [courseLabRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('readDocument stores the course', () async {
    final container = containerWith(
      const FakeCourseLabRepository(course: sampleCourse),
    );
    final sub = container.listen(firebaseFundamentalsProvider, (_, __) {});
    addTearDown(sub.close);

    await container.read(firebaseFundamentalsProvider.notifier).readDocument();

    expect(sub.read().document?.value, sampleCourse);
  });

  test('runValidQuery stores matching courses', () async {
    final container = containerWith(
      const FakeCourseLabRepository(courses: [sampleCourse]),
    );
    final sub = container.listen(firebaseFundamentalsProvider, (_, __) {});
    addTearDown(sub.close);

    await container.read(firebaseFundamentalsProvider.notifier).runValidQuery();

    expect(sub.read().validQuery?.value, [sampleCourse]);
  });

  test('runInvalidQuery stores InvalidQueryFailure', () async {
    final container = containerWith(
      const FakeCourseLabRepository(
        invalidQueryError: InvalidQueryFailure(detail: 'two inequalities'),
      ),
    );
    final sub = container.listen(firebaseFundamentalsProvider, (_, __) {});
    addTearDown(sub.close);

    await container
        .read(firebaseFundamentalsProvider.notifier)
        .runInvalidQuery();

    expect(
      sub.read().invalidQuery?.error,
      const InvalidQueryFailure(detail: 'two inequalities'),
    );
  });

  test('runCompositeQuery stores matching courses', () async {
    final container = containerWith(
      const FakeCourseLabRepository(courses: [sampleCourse]),
    );
    final sub = container.listen(firebaseFundamentalsProvider, (_, __) {});
    addTearDown(sub.close);

    await container
        .read(firebaseFundamentalsProvider.notifier)
        .runCompositeQuery();

    expect(sub.read().compositeQuery?.value, [sampleCourse]);
  });

  test('runMissingIndexQuery stores the index error', () async {
    final container = containerWith(
      const FakeCourseLabRepository(
        missingIndexError: InvalidQueryFailure(
          detail: 'The query requires an index.',
        ),
      ),
    );
    final sub = container.listen(firebaseFundamentalsProvider, (_, __) {});
    addTearDown(sub.close);

    await container
        .read(firebaseFundamentalsProvider.notifier)
        .runMissingIndexQuery();

    expect(
      sub.read().missingIndexQuery?.error,
      const InvalidQueryFailure(detail: 'The query requires an index.'),
    );
  });

  test('runCollectionGroupQuery stores lessons', () async {
    final container = containerWith(
      const FakeCourseLabRepository(lessons: [sampleLesson]),
    );
    final sub = container.listen(firebaseFundamentalsProvider, (_, __) {});
    addTearDown(sub.close);

    await container
        .read(firebaseFundamentalsProvider.notifier)
        .runCollectionGroupQuery();

    expect(sub.read().collectionGroupLessons?.value, [sampleLesson]);
  });

  test('readNestedLessons stores lessons for the sample course', () async {
    final container = containerWith(
      const FakeCourseLabRepository(lessons: [sampleLesson]),
    );
    final sub = container.listen(firebaseFundamentalsProvider, (_, __) {});
    addTearDown(sub.close);

    await container
        .read(firebaseFundamentalsProvider.notifier)
        .readNestedLessons();

    expect(sub.read().nestedLessons?.value, [sampleLesson]);
  });

  test('startRealtime stores the snapshot', () async {
    final container = containerWith(
      const FakeCourseLabRepository(courses: [sampleCourse]),
    );
    final sub = container.listen(firebaseFundamentalsProvider, (_, __) {});
    addTearDown(sub.close);

    container.read(firebaseFundamentalsProvider.notifier).startRealtime();
    await Future<void>.delayed(Duration.zero);

    expect(sub.read().listening, isTrue);
    expect(sub.read().realtime?.value?.courses, [sampleCourse]);
  });

  test('incrementParticipants stores AsyncData', () async {
    final container = containerWith(const FakeCourseLabRepository());
    final sub = container.listen(firebaseFundamentalsProvider, (_, __) {});
    addTearDown(sub.close);

    await container
        .read(firebaseFundamentalsProvider.notifier)
        .incrementParticipants();

    expect(sub.read().increment?.hasValue, isTrue);
  });
}
