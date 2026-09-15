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
  Future<List<CourseModel>> fetchCoursesByCategory(String category) {
    return _guard(() async {
      final snaps = await _collection
          .where('categories', arrayContains: category)
          .get(_server);
      final models = [
        for (final snap in snaps.docs)
          CourseModel.fromJson({...snap.data(), 'id': snap.id}),
      ];
      return List<CourseModel>.of(models)
        ..sort((a, b) => a.seqNo.compareTo(b.seqNo));
    });
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
