import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_in_depth/core/errors/app_exception.dart';
import 'package:firebase_in_depth/features/course_lab/data/data_sources/course_lab_data_source.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/course_model.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/courses_snapshot_model.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/lesson_model.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/courses_snapshot.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final courseLabDataSourceProvider = Provider<CourseLabDataSource>((ref) {
  return CourseLabDataSourceImpl(FirebaseFirestore.instance);
});

class CourseLabDataSourceImpl implements CourseLabDataSource {
  CourseLabDataSourceImpl(this._firestore);

  static const _courses = 'courses';
  static const _lessons = 'lessons';

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection {
    return _firestore.collection(_courses);
  }

  @override
  Future<CourseModel> fetchCourse(String id) {
    return _guard(() async {
      final snap = await _collection.doc(id).get();
      final data = snap.data();
      if (!snap.exists || data == null) {
        throw const NotFoundException();
      }
      return CourseModel.fromJson({...data, 'id': snap.id});
    });
  }

  @override
  Future<List<CourseModel>> fetchCourses() {
    return _guard(() => _mapQuery(_collection.orderBy('seqNo')));
  }

  @override
  Future<List<CourseModel>> fetchCoursesSeqNoAtMost(int seqNo) {
    return _guard(() {
      return _mapQuery(
        _collection.where('seqNo', isLessThanOrEqualTo: seqNo).orderBy('seqNo'),
      );
    });
  }

  @override
  Future<List<CourseModel>> fetchCoursesSeqNoAndLessonsCount({
    required int seqNo,
    required int lessonsCount,
  }) {
    return _guard(() {
      return _mapQuery(
        _collection
            .where('seqNo', isLessThanOrEqualTo: seqNo)
            .where('lessonsCount', isLessThanOrEqualTo: lessonsCount)
            .orderBy('seqNo'),
      );
    });
  }

  @override
  Future<List<CourseModel>> fetchCoursesSeqNoAndUrl({
    required int seqNo,
    required String url,
  }) {
    return _guard(() {
      return _mapQuery(
        _collection
            .where('seqNo', isLessThanOrEqualTo: seqNo)
            .where('url', isEqualTo: url)
            .orderBy('seqNo'),
      );
    });
  }

  @override
  Future<List<CourseModel>> fetchCoursesSeqNoAndPrice({
    required int seqNo,
    required int price,
  }) {
    return _guard(() {
      return _mapQuery(
        _collection
            .where('seqNo', isLessThanOrEqualTo: seqNo)
            .where('price', isEqualTo: price)
            .orderBy('seqNo'),
      );
    });
  }

  @override
  Future<List<LessonModel>> fetchLessonsForCourse(String courseId) {
    return _guard(() {
      return _mapLessons(
        _collection.doc(courseId).collection(_lessons).orderBy('seqNo'),
      );
    });
  }

  @override
  Future<List<LessonModel>> fetchLessonsCollectionGroup() {
    return _guard(() {
      return _mapLessons(_firestore.collectionGroup(_lessons).orderBy('seqNo'));
    });
  }

  @override
  Future<List<CourseModel>> fetchCoursesByCategory(String category) {
    return _guard(() async {
      final models = await _mapQuery(
        _collection.where('categories', arrayContains: category),
      );
      return List<CourseModel>.of(models)
        ..sort((a, b) => a.seqNo.compareTo(b.seqNo));
    });
  }

  @override
  Stream<CoursesSnapshotModel> watchCourses() {
    return _collection
        .orderBy('seqNo')
        .snapshots()
        .map(_mapCoursesSnapshot)
        .handleError((Object error, StackTrace stack) {
          Error.throwWithStackTrace(_toAppException(error), stack);
        });
  }

  @override
  Future<void> incrementParticipants(String courseId) {
    return _guard(() {
      return _collection.doc(courseId).update({
        'participants': FieldValue.increment(1),
      });
    });
  }

  Future<List<CourseModel>> _mapQuery(Query<Map<String, dynamic>> query) async {
    final snaps = await query.get();
    return [
      for (final snap in snaps.docs)
        CourseModel.fromJson({...snap.data(), 'id': snap.id}),
    ];
  }

  Future<List<LessonModel>> _mapLessons(
    Query<Map<String, dynamic>> query,
  ) async {
    final snaps = await query.get();
    return [
      for (final snap in snaps.docs)
        LessonModel.fromJson({
          ...snap.data(),
          'id': snap.id,
          'courseId': snap.reference.parent.parent?.id ?? '',
        }),
    ];
  }

  CoursesSnapshotModel _mapCoursesSnapshot(
    QuerySnapshot<Map<String, dynamic>> snap,
  ) {
    return CoursesSnapshotModel(
      courses: [
        for (final doc in snap.docs)
          CourseModel.fromJson({...doc.data(), 'id': doc.id}),
      ],
      changes: [
        for (final change in snap.docChanges)
          if (change.doc.data() != null)
            CourseChangeModel(
              type: _changeType(change.type),
              course: CourseModel.fromJson({
                ...change.doc.data()!,
                'id': change.doc.id,
              }),
            ),
      ],
    );
  }

  CourseChangeType _changeType(DocumentChangeType type) {
    return switch (type) {
      DocumentChangeType.added => CourseChangeType.added,
      DocumentChangeType.modified => CourseChangeType.modified,
      DocumentChangeType.removed => CourseChangeType.removed,
    };
  }

  AppException _toAppException(Object error) {
    return switch (error) {
      AppException() => error,
      FirebaseException() => AppException.fromFirebase(error),
      _ => const NetworkException(),
    };
  }

  Future<T> _guard<T>(Future<T> Function() run) async {
    try {
      return await run();
    } on AppException {
      rethrow;
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    } catch (_) {
      throw const NetworkException();
    }
  }
}
