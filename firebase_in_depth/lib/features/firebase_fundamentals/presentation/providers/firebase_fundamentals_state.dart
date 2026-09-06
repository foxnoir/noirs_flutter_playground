import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/course.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_fundamentals_state.freezed.dart';

@freezed
abstract class FirebaseFundamentalsState with _$FirebaseFundamentalsState {
  const factory FirebaseFundamentalsState({
    AsyncValue<Course>? document,
    AsyncValue<List<Course>>? collection,
    AsyncValue<List<Course>>? validQuery,
    AsyncValue<List<Course>>? invalidQuery,
    AsyncValue<List<Course>>? missingIndexQuery,
  }) = _FirebaseFundamentalsState;
}
