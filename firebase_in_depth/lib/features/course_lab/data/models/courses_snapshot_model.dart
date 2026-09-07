import 'package:firebase_in_depth/features/firebase_fundamentals/data/models/course_model.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/courses_snapshot.dart';
import 'package:meta/meta.dart';

@immutable
class CourseChangeModel {
  const CourseChangeModel({required this.type, required this.course});

  final CourseChangeType type;
  final CourseModel course;

  CourseChange toEntity() {
    return CourseChange(type: type, course: course.toEntity());
  }
}

@immutable
class CoursesSnapshotModel {
  const CoursesSnapshotModel({required this.courses, required this.changes});

  final List<CourseModel> courses;
  final List<CourseChangeModel> changes;

  CoursesSnapshot toEntity() {
    return CoursesSnapshot(
      courses: [for (final course in courses) course.toEntity()],
      changes: [for (final change in changes) change.toEntity()],
    );
  }
}
