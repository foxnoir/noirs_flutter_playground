import 'package:firebase_in_depth/features/course_lab/data/data_sources/course_lab_data_source.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/course_model.dart';

class FakeCourseLabDataSource implements CourseLabDataSource {
  const FakeCourseLabDataSource({this.models = const [], this.error});

  final List<CourseModel> models;
  final Exception? error;

  @override
  Future<List<CourseModel>> fetchCourses() async {
    final thrown = error;
    if (thrown != null) throw thrown;
    return List<CourseModel>.of(models)
      ..sort((a, b) => a.seqNo.compareTo(b.seqNo));
  }

  @override
  Future<List<CourseModel>> fetchCoursesByCategory(String category) async {
    final thrown = error;
    if (thrown != null) throw thrown;
    return [
      for (final model in models)
        if (model.categories.contains(category)) model,
    ]..sort((a, b) => a.seqNo.compareTo(b.seqNo));
  }
}
