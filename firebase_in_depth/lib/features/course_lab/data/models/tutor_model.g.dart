// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TutorModel _$TutorModelFromJson(Map<String, dynamic> json) => _TutorModel(
  name: json['name'] as String,
  employedSince: (json['employedSince'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$TutorModelToJson(_TutorModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'employedSince': instance.employedSince,
    };
