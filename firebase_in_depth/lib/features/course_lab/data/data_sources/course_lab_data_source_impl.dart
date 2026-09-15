import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_in_depth/core/errors/app_exception.dart';
import 'package:firebase_in_depth/features/course_lab/data/data_sources/course_lab_data_source.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/course_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final courseLabDataSourceProvider = Provider<CourseLabDataSource>((ref) {
  return CourseLabDataSourceImpl(FirebaseFirestore.instance);
});

class CourseLabDataSourceImpl implements CourseLabDataSource {
  CourseLabDataSourceImpl(this._firestore);

  static const _courses = 'courses';

  /// Default `get()` can return an empty cache when the server is down.
  static const _server = GetOptions(source: Source.server);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection {
    return _firestore.collection(_courses);
  }

  @override
  Future<List<CourseModel>> fetchCourses() {
    return _guard(() async {
      final snaps = await _collection.get(_server);
      return _models(snaps.docs);
    });
  }

  @override
  Future<List<CourseModel>> fetchCoursesByCategory(String category) {
    return _guard(() async {
      final snaps = await _collection
          .where('categories', arrayContains: category)
          .get(_server);
      return _models(snaps.docs);
    });
  }

  @override
  Future<void> deleteCourse(String id) {
    return _guard(() => _collection.doc(id).delete());
  }

  @override
  Future<CourseModel> createCourse(CourseModel course) {
    return _guard(() async {
      var written = course;
      try {
        await _createDoc(written);
      } on FirebaseException catch (e) {
        if (e.code != 'already-exists') rethrow;
        final fallbackId = '${course.id}-${course.seqNo}';
        written = course.copyWith(id: fallbackId, url: fallbackId);
        await _createDoc(written);
      }
      return written;
    });
  }

  /// Flutter's [DocumentReference] has no `create()`. Read first so a slug
  /// collision does not overwrite the existing course.
  Future<void> _createDoc(CourseModel course) async {
    final ref = _collection.doc(course.id);
    final existing = await ref.get(_server);
    if (existing.exists) {
      throw FirebaseException(
        plugin: 'cloud_firestore',
        code: 'already-exists',
        message: 'Document already exists',
      );
    }
    await ref.set(_payload(course));
  }

  Map<String, dynamic> _payload(CourseModel course) {
    return {
      'description': course.description,
      'longDescription': course.longDescription,
      'url': course.url,
      'seqNo': course.seqNo,
      'lessonsCount': course.lessonsCount,
      'price': course.price,
      'categories': course.categories,
      'icon': course.icon,
      'tutor': {
        'name': course.tutor.name,
        'employedSince': course.tutor.employedSince,
      },
      'participants': course.participants,
    };
  }

  List<CourseModel> _models(
    Iterable<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    return [
      for (final snap in docs)
        CourseModel.fromJson({...snap.data(), 'id': snap.id}),
    ]..sort((a, b) => a.seqNo.compareTo(b.seqNo));
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
