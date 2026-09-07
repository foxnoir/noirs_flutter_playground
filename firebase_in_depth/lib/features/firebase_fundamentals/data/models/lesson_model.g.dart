// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => _LessonModel(
  id: json['id'] as String,
  courseId: json['courseId'] as String,
  description: json['description'] as String,
  duration: json['duration'] as String,
  seqNo: (json['seqNo'] as num).toInt(),
);

Map<String, dynamic> _$LessonModelToJson(_LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'description': instance.description,
      'duration': instance.duration,
      'seqNo': instance.seqNo,
    };
