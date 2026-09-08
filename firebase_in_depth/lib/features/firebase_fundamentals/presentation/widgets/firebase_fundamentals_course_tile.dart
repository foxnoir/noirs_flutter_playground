import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FirebaseFundamentalsCourseTile extends StatelessWidget {
  const FirebaseFundamentalsCourseTile({
    required this.course,
    this.showParticipants = false,
    this.iconTrailing = false,
    super.key,
  });

  final Course course;
  final bool showParticipants;
  final bool iconTrailing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final icon = Image.asset(
      'assets/icons/courses/course_${course.icon}.png',
      width: 40,
      height: 40,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.menu_book_outlined);
      },
    );

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: iconTrailing ? null : icon,
      trailing: iconTrailing ? icon : null,
      title: Text(course.description),
      subtitle: Text(
        showParticipants
            ? l10n.fundamentalsRealtimeCourseMeta(
                course.seqNo,
                course.lessonsCount,
                course.participants,
              )
            : l10n.fundamentalsCourseMeta(course.seqNo, course.lessonsCount),
      ),
    );
  }
}
