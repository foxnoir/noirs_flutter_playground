import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/lesson.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FirebaseFundamentalsLessonTile extends StatelessWidget {
  const FirebaseFundamentalsLessonTile({required this.lesson, super.key});

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
