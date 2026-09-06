import 'package:freezed_annotation/freezed_annotation.dart';

part 'tutor.freezed.dart';

@freezed
abstract class Tutor with _$Tutor {
  const factory Tutor({
    required String name,
    required List<int> employedSince,
  }) = _Tutor;
}
