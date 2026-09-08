import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/course_lab/data/repositories/course_lab_repository_impl.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/providers/course_lab_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../course_fixtures.dart';
import '../../fake_course_lab_repository.dart';

void main() {
  ProviderContainer containerWith(FakeCourseLabRepository repository) {
    final container = ProviderContainer.test(
      overrides: [courseLabRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('build loads beginner and advanced in parallel', () async {
    final container = containerWith(
      const FakeCourseLabRepository(
        courses: [sampleCourse, sampleAdvancedCourse],
      ),
    );
    final sub = container.listen(courseLabProvider, (_, __) {});
    addTearDown(sub.close);

    await container.read(courseLabProvider.notifier).reload();

    expect(sub.read().beginner.value, [sampleCourse]);
    expect(sub.read().advanced.value, [sampleAdvancedCourse]);
  });

  test('reload stores a failure on both tracks', () async {
    final container = containerWith(
      const FakeCourseLabRepository(error: NetworkFailure()),
    );
    final sub = container.listen(courseLabProvider, (_, __) {});
    addTearDown(sub.close);

    await container.read(courseLabProvider.notifier).reload();

    expect(sub.read().beginner.error, const NetworkFailure());
    expect(sub.read().advanced.error, const NetworkFailure());
  });
}
