import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson.freezed.dart';

@freezed
abstract class Lesson with _$Lesson {
  const factory Lesson({
    required String id,
    required String courseId,
    required String description,
    required String duration,
    required int seqNo,
  }) = _Lesson;
}
