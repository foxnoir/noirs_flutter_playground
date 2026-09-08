import 'package:firebase_in_depth/features/course_lab/data/models/lesson_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../course_fixtures.dart';

void main() {
  test('fromJson maps seqNo from num', () {
    final json = <String, dynamic>{...sampleLessonJson, 'seqNo': 1.0};

    expect(LessonModel.fromJson(json).toEntity(), sampleLesson);
  });
}
