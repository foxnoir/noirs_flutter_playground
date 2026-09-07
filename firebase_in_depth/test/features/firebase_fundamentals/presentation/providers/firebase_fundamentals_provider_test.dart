import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/data/repositories/firebase_fundamentals_repository.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/providers/firebase_fundamentals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../course_fixtures.dart';
import '../../fake_firebase_fundamentals_repository.dart';

void main() {
  ProviderContainer containerWith(
    FakeFirebaseFundamentalsRepository repository,
  ) {
    final container = ProviderContainer.test(
      overrides: [
        firebaseFundamentalsRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('readDocument stores the course', () async {
    final container = containerWith(
      const FakeFirebaseFundamentalsRepository(course: sampleCourse),
    );
    final sub = container.listen(firebaseFundamentalsProvider, (_, __) {});
    addTearDown(sub.close);

    await container.read(firebaseFundamentalsProvider.notifier).readDocument();

    expect(sub.read().document?.value, sampleCourse);
  });

  test('runValidQuery stores matching courses', () async {
    final container = containerWith(
      const FakeFirebaseFundamentalsRepository(courses: [sampleCourse]),
    );
    final sub = container.listen(firebaseFundamentalsProvider, (_, __) {});
    addTearDown(sub.close);

    await container.read(firebaseFundamentalsProvider.notifier).runValidQuery();

    expect(sub.read().validQuery?.value, [sampleCourse]);
  });

  test('runInvalidQuery stores InvalidQueryFailure', () async {
    final container = containerWith(
      const FakeFirebaseFundamentalsRepository(
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
      const FakeFirebaseFundamentalsRepository(courses: [sampleCourse]),
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
      const FakeFirebaseFundamentalsRepository(
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
      const FakeFirebaseFundamentalsRepository(lessons: [sampleLesson]),
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
      const FakeFirebaseFundamentalsRepository(lessons: [sampleLesson]),
    );
    final sub = container.listen(firebaseFundamentalsProvider, (_, __) {});
    addTearDown(sub.close);

    await container
        .read(firebaseFundamentalsProvider.notifier)
        .readNestedLessons();

    expect(sub.read().nestedLessons?.value, [sampleLesson]);
  });
}
