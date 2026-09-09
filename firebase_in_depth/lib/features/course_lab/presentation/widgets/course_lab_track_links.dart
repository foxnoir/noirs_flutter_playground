import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

enum CourseLabTrack {
  beginner,
  advanced,
  expert;

  /// Firestore `categories` value.
  /// Seed uses `INTERMEDIATE`, not Angular's `ADVANCE`.
  /// Expert is `EXPERTS`.
  String get category => switch (this) {
    beginner => 'BEGINNER',
    advanced => 'INTERMEDIATE',
    expert => 'EXPERTS',
  };

  String get iconAsset => 'assets/icons/categories/$name.png';

  String label(AppLocalizations l10n) => switch (this) {
    beginner => l10n.courseLabBeginner,
    advanced => l10n.courseLabAdvanced,
    expert => l10n.courseLabExpert,
  };

  String headline(AppLocalizations l10n) => switch (this) {
    beginner => l10n.courseLabBeginnerHeadline,
    advanced => l10n.courseLabAdvancedHeadline,
    expert => l10n.courseLabExpertHeadline,
  };

  String body(AppLocalizations l10n) => switch (this) {
    beginner => l10n.courseLabBeginnerBody,
    advanced => l10n.courseLabAdvancedBody,
    expert => l10n.courseLabExpertBody,
  };

  CrossAxisAlignment get contentAlign => switch (this) {
    beginner => CrossAxisAlignment.start,
    advanced => CrossAxisAlignment.center,
    expert => CrossAxisAlignment.end,
  };

  TextAlign get textAlign => switch (this) {
    beginner => TextAlign.start,
    advanced => TextAlign.center,
    expert => TextAlign.end,
  };

  Alignment get listAlign => switch (this) {
    beginner => Alignment.topLeft,
    advanced => Alignment.topCenter,
    expert => Alignment.topRight,
  };

  Alignment? get overlayDragonAlign => switch (this) {
    beginner => Alignment.bottomRight,
    advanced => null,
    expert => Alignment.bottomLeft,
  };

  bool get overlayDragonMirrored => this == expert;

  String get noCoursesDragonAsset => switch (this) {
    advanced => 'assets/img/no_courses_advanced_dragon.png',
    beginner || expert => 'assets/img/no_courses_dragon.png',
  };

  /// Beginner turquoise, Advanced light purple, Expert dark purple.
  Color tabAccent(ThemeData theme) => switch (this) {
    beginner => theme.colorScheme.secondary,
    advanced => theme.colorScheme.primaryContainer,
    expert => theme.textTheme.titleLarge?.color ?? theme.colorScheme.onSurface,
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
        for (final value in CourseLabTrack.values)
          Expanded(
            child: _TrackLink(
              key: Key('course-lab-track-${value.name}'),
              label: value.label(l10n),
              accent: value.tabAccent(Theme.of(context)),
              selected: track == value,
              onTap: () => onChanged(value),
            ),
          ),
      ],
    );
  }
}

class _TrackLink extends StatelessWidget {
  const _TrackLink({
    required this.label,
    required this.accent,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final Color accent;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = selected ? accent : scheme.onSurfaceVariant;

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
                  color: selected ? accent : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: color,
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
