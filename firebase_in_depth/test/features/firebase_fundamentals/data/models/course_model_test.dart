import 'package:firebase_in_depth/features/firebase_fundamentals/data/models/course_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../course_fixtures.dart';

void main() {
  test('fromJson maps nested tutor and ints from num', () {
    final json = <String, dynamic>{
      ...sampleCourseJson,
      'seqNo': 1.0,
      'lessonsCount': 3.0,
      'price': 29.0,
      'tutor': <String, dynamic>{
        'name': 'Noir',
        'employedSince': [2020.0, 4.0, 1.0],
      },
    };

    expect(CourseModel.fromJson(json).toEntity(), sampleCourse);
  });

  test('fromJson defaults missing participants to 0', () {
    expect(CourseModel.fromJson(sampleCourseJson).participants, 0);
  });
}
