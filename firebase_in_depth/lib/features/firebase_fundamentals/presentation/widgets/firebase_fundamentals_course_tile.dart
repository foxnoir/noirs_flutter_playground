import 'package:firebase_in_depth/features/firebase_fundamentals/domain/entities/course.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FirebaseFundamentalsCourseTile extends StatelessWidget {
  const FirebaseFundamentalsCourseTile({required this.course, super.key});

  final Course course;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        'assets/icons/courses/course_${course.icon}.png',
        width: 40,
        height: 40,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.menu_book_outlined);
        },
      ),
      title: Text(course.description),
      subtitle: Text(
        l10n.fundamentalsCourseMeta(course.seqNo, course.lessonsCount),
      ),
    );
  }
}
