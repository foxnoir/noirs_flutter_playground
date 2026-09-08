import 'package:firebase_in_depth/features/course_lab/data/models/course_model.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/lesson_model.dart';
import 'package:firebase_in_depth/features/course_lab/data/models/tutor_model.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/lesson.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/tutor.dart';

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

const sampleAdvancedCourse = Course(
  id: 'keigo-essentials',
  description: 'Keigo Essentials',
  longDescription: 'Honorifics for work.',
  url: 'keigo-essentials',
  seqNo: 5,
  lessonsCount: 4,
  price: 49,
  categories: ['INTERMEDIATE'],
  icon: 'green',
  tutor: Tutor(name: 'Noir', employedSince: [2020, 4, 1]),
);

const sampleAdvancedCourseModel = CourseModel(
  id: 'keigo-essentials',
  description: 'Keigo Essentials',
  longDescription: 'Honorifics for work.',
  url: 'keigo-essentials',
  seqNo: 5,
  lessonsCount: 4,
  price: 49,
  categories: ['INTERMEDIATE'],
  icon: 'green',
  tutor: TutorModel(name: 'Noir', employedSince: [2020, 4, 1]),
);

const sampleExpertCourse = Course(
  id: 'newspaper-japanese',
  description: 'Newspaper Japanese',
  longDescription: 'Headlines, keigo in print, and the grammar papers skip.',
  url: 'newspaper-japanese',
  seqNo: 9,
  lessonsCount: 8,
  price: 59,
  categories: ['EXPERTS'],
  icon: 'turquoise',
  tutor: Tutor(name: 'Noir', employedSince: [2020, 4, 1]),
);

const sampleExpertCourseModel = CourseModel(
  id: 'newspaper-japanese',
  description: 'Newspaper Japanese',
  longDescription: 'Headlines, keigo in print, and the grammar papers skip.',
  url: 'newspaper-japanese',
  seqNo: 9,
  lessonsCount: 8,
  price: 59,
  categories: ['EXPERTS'],
  icon: 'turquoise',
  tutor: TutorModel(name: 'Noir', employedSince: [2020, 4, 1]),
);

const sampleLessonJson = {
  'id': 'lesson-vowels',
  'courseId': 'hiragana-from-zero',
  'description': 'Vowels',
  'duration': '06:05',
  'seqNo': 1,
};

const sampleLesson = Lesson(
  id: 'lesson-vowels',
  courseId: 'hiragana-from-zero',
  description: 'Vowels',
  duration: '06:05',
  seqNo: 1,
);

const sampleLessonModel = LessonModel(
  id: 'lesson-vowels',
  courseId: 'hiragana-from-zero',
  description: 'Vowels',
  duration: '06:05',
  seqNo: 1,
);
