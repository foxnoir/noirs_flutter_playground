import 'dart:async';

import 'package:firebase_in_depth/features/course_lab/data/repositories/course_lab_repository_impl.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/courses_snapshot.dart';
import 'package:firebase_in_depth/features/course_lab/domain/repositories/course_lab_repository.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/providers/firebase_fundamentals_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const sampleCourseId = 'hiragana-from-zero';
const querySeqNoAtMost = 5;
const queryLessonsCountAtMost = 10;
const queryIndexSeqNoAtMost = 20;
const queryIndexPrice = 15;

final firebaseFundamentalsProvider =
    NotifierProvider.autoDispose<
      FirebaseFundamentalsNotifier,
      FirebaseFundamentalsState
    >(FirebaseFundamentalsNotifier.new);

class FirebaseFundamentalsNotifier extends Notifier<FirebaseFundamentalsState> {
  StreamSubscription<CoursesSnapshot>? _realtime;

  @override
  FirebaseFundamentalsState build() {
    ref.onDispose(() => _realtime?.cancel());
    return const FirebaseFundamentalsState();
  }

  CourseLabRepository get _repository {
    return ref.read(courseLabRepositoryProvider);
  }

  Future<void> readDocument() {
    return _run(
      setValue: (value) => state = state.copyWith(document: value),
      run: () => _repository.fetchCourse(sampleCourseId),
    );
  }

  Future<void> readCollection() {
    return _run(
      setValue: (value) => state = state.copyWith(collection: value),
      run: _repository.fetchCourses,
    );
  }

  Future<void> runValidQuery() {
    return _run(
      setValue: (value) => state = state.copyWith(validQuery: value),
      run: () => _repository.fetchCoursesSeqNoAtMost(querySeqNoAtMost),
    );
  }

  Future<void> runInvalidQuery() {
    return _run(
      setValue: (value) => state = state.copyWith(invalidQuery: value),
      run: () => _repository.fetchCoursesSeqNoAndLessonsCount(
        seqNo: querySeqNoAtMost,
        lessonsCount: queryLessonsCountAtMost,
      ),
    );
  }

  Future<void> runCompositeQuery() {
    return _run(
      setValue: (value) => state = state.copyWith(compositeQuery: value),
      run: () => _repository.fetchCoursesSeqNoAndUrl(
        seqNo: queryIndexSeqNoAtMost,
        url: sampleCourseId,
      ),
    );
  }

  Future<void> runMissingIndexQuery() {
    return _run(
      setValue: (value) => state = state.copyWith(missingIndexQuery: value),
      run: () => _repository.fetchCoursesSeqNoAndPrice(
        seqNo: queryIndexSeqNoAtMost,
        price: queryIndexPrice,
      ),
    );
  }

  Future<void> readNestedLessons() {
    return _run(
      setValue: (value) => state = state.copyWith(nestedLessons: value),
      run: () => _repository.fetchLessonsForCourse(sampleCourseId),
    );
  }

  Future<void> runCollectionGroupQuery() {
    return _run(
      setValue: (value) =>
          state = state.copyWith(collectionGroupLessons: value),
      run: _repository.fetchLessonsCollectionGroup,
    );
  }

  void startRealtime() {
    unawaited(_realtime?.cancel());
    state = state.copyWith(listening: true, realtime: const AsyncLoading());
    _realtime = _repository.watchCourses().listen(
      (snapshot) {
        state = state.copyWith(listening: true, realtime: AsyncData(snapshot));
      },
      onError: (Object error, StackTrace stackTrace) {
        state = state.copyWith(
          listening: true,
          realtime: AsyncError<CoursesSnapshot>(error, stackTrace),
        );
      },
    );
  }

  void stopRealtime() {
    unawaited(_realtime?.cancel());
    _realtime = null;
    state = state.copyWith(listening: false);
  }

  Future<void> incrementParticipants() {
    return _run(
      setValue: (value) => state = state.copyWith(increment: value),
      run: () => _repository.incrementParticipants(sampleCourseId),
    );
  }

  Future<void> _run<T>({
    required void Function(AsyncValue<T> value) setValue,
    required Future<T> Function() run,
  }) async {
    setValue(AsyncLoading<T>());
    setValue(await AsyncValue.guard(run));
  }
}
