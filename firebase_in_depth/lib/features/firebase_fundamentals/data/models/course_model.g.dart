// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => _CourseModel(
  id: json['id'] as String,
  description: json['description'] as String,
  longDescription: json['longDescription'] as String,
  url: json['url'] as String,
  seqNo: (json['seqNo'] as num).toInt(),
  lessonsCount: (json['lessonsCount'] as num).toInt(),
  price: (json['price'] as num).toInt(),
  categories: (json['categories'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  icon: json['icon'] as String,
  tutor: TutorModel.fromJson(json['tutor'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CourseModelToJson(_CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'longDescription': instance.longDescription,
      'url': instance.url,
      'seqNo': instance.seqNo,
      'lessonsCount': instance.lessonsCount,
      'price': instance.price,
      'categories': instance.categories,
      'icon': instance.icon,
      'tutor': instance.tutor,
    };
