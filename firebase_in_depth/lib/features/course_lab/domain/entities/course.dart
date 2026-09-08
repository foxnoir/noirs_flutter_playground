import 'package:firebase_in_depth/features/course_lab/domain/entities/tutor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';

@freezed
abstract class Course with _$Course {
  const factory Course({
    required String id,
    required String description,
    required String longDescription,
    required String url,
    required int seqNo,
    required int lessonsCount,
    required int price,
    required List<String> categories,
    required String icon,
    required Tutor tutor,
    @Default(0) int participants,
  }) = _Course;
}
