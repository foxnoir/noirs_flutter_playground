import 'package:firebase_in_depth/features/firebase_fundamentals/data/models/course_model.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/data/models/tutor_model.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/course.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/tutor.dart';

const sampleCourseJson = {
  'id': 'hiragana-from-zero',
  'description': 'Hiragana from Zero',
  'longDescription': 'Learn the 46 hiragana.',
  'url': 'hiragana-from-zero',
  'seqNo': 1,
  'lessonsCount': 3,
  'price': 29,
  'categories': ['BEGINNER'],
  'icon': 'purple',
  'tutor': {
    'name': 'Noir',
    'employedSince': [2020, 4, 1],
  },
};

const sampleCourse = Course(
  id: 'hiragana-from-zero',
  description: 'Hiragana from Zero',
  longDescription: 'Learn the 46 hiragana.',
  url: 'hiragana-from-zero',
  seqNo: 1,
  lessonsCount: 3,
  price: 29,
  categories: ['BEGINNER'],
  icon: 'purple',
  tutor: Tutor(name: 'Noir', employedSince: [2020, 4, 1]),
);

const sampleCourseModel = CourseModel(
  id: 'hiragana-from-zero',
  description: 'Hiragana from Zero',
  longDescription: 'Learn the 46 hiragana.',
  url: 'hiragana-from-zero',
  seqNo: 1,
  lessonsCount: 3,
  price: 29,
  categories: ['BEGINNER'],
  icon: 'purple',
  tutor: TutorModel(name: 'Noir', employedSince: [2020, 4, 1]),
);
