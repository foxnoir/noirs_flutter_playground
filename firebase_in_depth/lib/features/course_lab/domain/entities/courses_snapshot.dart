import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/course.dart';
import 'package:meta/meta.dart';

enum CourseChangeType { added, modified, removed }

@immutable
class CourseChange {
  const CourseChange({required this.type, required this.course});

  final CourseChangeType type;
  final Course course;

  @override
  bool operator ==(Object other) {
    return other is CourseChange &&
        type == other.type &&
        course == other.course;
  }

  @override
  int get hashCode => Object.hash(type, course);
}

/// One `snapshots()` emission: current docs plus this batch of `docChanges`.
@immutable
class CoursesSnapshot {
  const CoursesSnapshot({required this.courses, required this.changes});

  final List<Course> courses;
  final List<CourseChange> changes;

  @override
  bool operator ==(Object other) {
    return other is CoursesSnapshot &&
        _listEquals(courses, other.courses) &&
        _listEquals(changes, other.changes);
  }

  @override
  int get hashCode =>
      Object.hash(Object.hashAll(courses), Object.hashAll(changes));
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
