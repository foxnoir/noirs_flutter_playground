import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/lesson.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_lesson_tile.dart';
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
      children: [
        for (final lesson in lessons)
          FirebaseFundamentalsLessonTile(lesson: lesson),
      ],
    );
  }
}
