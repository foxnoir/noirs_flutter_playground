import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

enum CourseLabTrack {
  beginner,
  advanced;

  /// Firestore `categories` value.
  /// Seed uses `INTERMEDIATE`, not Angular's `ADVANCE`.
  String get category => switch (this) {
    beginner => 'BEGINNER',
    advanced => 'INTERMEDIATE',
  };
}

class CourseLabTrackLinks extends StatelessWidget {
  const CourseLabTrackLinks({
    required this.track,
    required this.onChanged,
    super.key,
  });

  final CourseLabTrack track;
  final ValueChanged<CourseLabTrack> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: _TrackLink(
            key: const Key('course-lab-track-beginner'),
            label: l10n.courseLabBeginner,
            selected: track == CourseLabTrack.beginner,
            onTap: () => onChanged(CourseLabTrack.beginner),
          ),
        ),
        Expanded(
          child: _TrackLink(
            key: const Key('course-lab-track-advanced'),
            label: l10n.courseLabAdvanced,
            selected: track == CourseLabTrack.advanced,
            onTap: () => onChanged(CourseLabTrack.advanced),
          ),
        ),
      ],
    );
  }
}

class _TrackLink extends StatelessWidget {
  const _TrackLink({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Align(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: selected ? scheme.primary : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: selected ? scheme.primary : scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
