import 'package:firebase_in_depth/features/course_lab/domain/entities/tutor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tutor_model.freezed.dart';
part 'tutor_model.g.dart';

@freezed
abstract class TutorModel with _$TutorModel {
  const factory TutorModel({
    required String name,
    required List<int> employedSince,
  }) = _TutorModel;

  factory TutorModel.fromJson(Map<String, dynamic> json) =>
      _$TutorModelFromJson(json);
}

extension TutorModelX on TutorModel {
  Tutor toEntity() {
    return Tutor(name: name, employedSince: employedSince);
  }
}
