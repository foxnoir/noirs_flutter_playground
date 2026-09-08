import 'package:firebase_in_depth/features/course_lab/domain/entities/lesson.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_model.freezed.dart';
part 'lesson_model.g.dart';

@freezed
abstract class LessonModel with _$LessonModel {
  const factory LessonModel({
    required String id,
    required String courseId,
    required String description,
    required String duration,
    required int seqNo,
  }) = _LessonModel;

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);
}

extension LessonModelX on LessonModel {
  Lesson toEntity() {
    return Lesson(
      id: id,
      courseId: courseId,
      description: description,
      duration: duration,
      seqNo: seqNo,
    );
  }
}
