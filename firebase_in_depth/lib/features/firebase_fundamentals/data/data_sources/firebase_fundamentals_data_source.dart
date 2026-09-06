import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_in_depth/core/errors/app_exception.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/data/models/course_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class FirebaseFundamentalsDataSource {
  Future<CourseModel> fetchCourse(String id);

  Future<List<CourseModel>> fetchCourses();

  Future<List<CourseModel>> fetchCoursesSeqNoAtMost(int seqNo);

  Future<List<CourseModel>> fetchCoursesSeqNoAndLessonsCount({
    required int seqNo,
    required int lessonsCount,
  });

  Future<List<CourseModel>> fetchCoursesSeqNoAndUrl({
    required int seqNo,
    required String url,
  });
}

final firebaseFundamentalsDataSourceProvider =
    Provider<FirebaseFundamentalsDataSource>((ref) {
      return FirebaseFundamentalsDataSourceImpl(FirebaseFirestore.instance);
    });

class FirebaseFundamentalsDataSourceImpl
    implements FirebaseFundamentalsDataSource {
  FirebaseFundamentalsDataSourceImpl(this._firestore);

  static const _courses = 'courses';

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

  Future<List<CourseModel>> _mapQuery(Query<Map<String, dynamic>> query) async {
    final snaps = await query.get();
    return [
      for (final snap in snaps.docs)
        CourseModel.fromJson({...snap.data(), 'id': snap.id}),
    ];
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
