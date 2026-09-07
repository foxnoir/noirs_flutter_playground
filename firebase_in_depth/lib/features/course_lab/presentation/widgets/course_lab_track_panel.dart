import 'package:firebase_in_depth/features/course_lab/presentation/course_lab_track.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CourseLabTrackPanel extends StatelessWidget {
  const CourseLabTrackPanel({required this.track, super.key});

  final CourseLabTrack track;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final beginner = track == CourseLabTrack.beginner;
    final accent = beginner ? scheme.primary : scheme.secondary;
    final onAccent = beginner ? scheme.onPrimary : scheme.onSecondary;

    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surface.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: accent.withValues(alpha: 0.35)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    beginner
                        ? Icons.auto_stories_outlined
                        : Icons.school_outlined,
                    color: onAccent,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                beginner
                    ? l10n.courseLabBeginnerHeadline
                    : l10n.courseLabAdvancedHeadline,
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                beginner
                    ? l10n.courseLabBeginnerBody
                    : l10n.courseLabAdvancedBody,
                style: textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
