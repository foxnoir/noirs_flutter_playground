import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseLabState {
  const CourseLabState({
    required this.beginner,
    required this.advanced,
    required this.expert,
  });

  final AsyncValue<List<Course>> beginner;
  final AsyncValue<List<Course>> advanced;
  final AsyncValue<List<Course>> expert;
}
