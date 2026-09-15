import 'package:firebase_in_depth/core/errors/app_failure.dart';
import 'package:firebase_in_depth/features/course_lab/data/repositories/course_lab_repository_impl.dart';
import 'package:firebase_in_depth/features/my_courses/presentation/providers/my_courses_provider.dart';
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

  test('build loads the catalog', () async {
    final container = containerWith(
      const FakeCourseLabRepository(
        courses: [sampleExpertCourse, sampleCourse, sampleAdvancedCourse],
      ),
    );
    final sub = container.listen(myCoursesProvider, (_, __) {});
    addTearDown(sub.close);

    await container.read(myCoursesProvider.notifier).reload();

    expect(sub.read().value, [
      sampleCourse,
      sampleAdvancedCourse,
      sampleExpertCourse,
    ]);
  });

  test('reload stores a failure', () async {
    final container = containerWith(
      const FakeCourseLabRepository(error: NetworkFailure()),
    );
    final sub = container.listen(myCoursesProvider, (_, __) {});
    addTearDown(sub.close);

    await container.read(myCoursesProvider.notifier).reload();

    expect(sub.read().error, const NetworkFailure());
  });
}
