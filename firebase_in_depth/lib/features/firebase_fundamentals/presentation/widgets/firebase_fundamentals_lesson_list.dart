import 'package:firebase_in_depth/features/course_lab/domain/entities/lesson.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FirebaseFundamentalsLessonList extends StatelessWidget {
  const FirebaseFundamentalsLessonList({required this.lessons, super.key});

  final List<Lesson> lessons;

  @override
  Widget build(BuildContext context) {
    if (lessons.isEmpty) {
      return Text(
        AppLocalizations.of(context).fundamentalsEmpty,
        style: Theme.of(context).textTheme.bodySmall,
      );
    }

    return Column(
      children: [for (final lesson in lessons) _LessonTile(lesson: lesson)],
    );
  }
}

class _LessonTile extends StatelessWidget {
  const _LessonTile({required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.play_lesson_outlined),
      title: Text(lesson.description),
      subtitle: Text(
        l10n.fundamentalsLessonMeta(
          lesson.courseId,
          lesson.seqNo,
          lesson.duration,
        ),
      ),
    );
  }
}
