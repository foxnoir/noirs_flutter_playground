import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/course.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_course_tile.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FirebaseFundamentalsCourseList extends StatelessWidget {
  const FirebaseFundamentalsCourseList({
    required this.courses,
    this.showParticipants = false,
    super.key,
  });

  final List<Course> courses;
  final bool showParticipants;

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return Text(
        AppLocalizations.of(context).fundamentalsEmpty,
        style: Theme.of(context).textTheme.bodySmall,
      );
    }

    return Column(
      children: [
        for (final course in courses)
          FirebaseFundamentalsCourseTile(
            course: course,
            showParticipants: showParticipants,
          ),
      ],
    );
  }
}
