import 'package:firebase_in_depth/features/firebase_fundamentals/data/models/tutor_model.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/course.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_model.freezed.dart';
part 'course_model.g.dart';

@freezed
abstract class CourseModel with _$CourseModel {
  const factory CourseModel({
    required String id,
    required String description,
    required String longDescription,
    required String url,
    required int seqNo,
    required int lessonsCount,
    required int price,
    required List<String> categories,
    required String icon,
    required TutorModel tutor,
  }) = _CourseModel;

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);
}

extension CourseModelX on CourseModel {
  Course toEntity() {
    return Course(
      id: id,
      description: description,
      longDescription: longDescription,
      url: url,
      seqNo: seqNo,
      lessonsCount: lessonsCount,
      price: price,
      categories: categories,
      icon: icon,
      tutor: tutor.toEntity(),
    );
  }
}
