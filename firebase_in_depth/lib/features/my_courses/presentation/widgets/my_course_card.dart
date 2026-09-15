import 'package:firebase_in_depth/core/theme/app_color.dart';
import 'package:firebase_in_depth/features/course_lab/domain/entities/course.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/widgets/course_lab_track_links.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:firebase_in_depth/shared_widgets/gradient_button.dart';
import 'package:flutter/material.dart';

class MyCourseCard extends StatelessWidget {
  const MyCourseCard({
    required this.course,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  static const videoPlaceholderAsset = 'assets/img/video_placeholder.png';

  final Course course;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final track = CourseLabTrack.fromCategories(course.categories);
    final canManage = onEdit != null || onDelete != null;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: track.tabAccent(theme).withValues(alpha: 0.4),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                videoPlaceholderAsset,
                fit: BoxFit.cover,
                semanticLabel: l10n.myCoursesVideoPlaceholder,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.description, style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    course.longDescription,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                      height: 1.45,
                    ),
                  ),
                  if (canManage) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (onEdit != null)
                          GradientButton(
                            key: Key('my-course-edit-${course.id}'),
                            label: l10n.myCoursesEdit,
                            compact: true,
                            onPressed: onEdit,
                          ),
                        const Spacer(),
                        if (onDelete != null)
                          IconButton(
                            key: Key('my-course-delete-${course.id}'),
                            tooltip: l10n.myCoursesDelete,
                            onPressed: onDelete,
                            color: AppColor.onError,
                            style: IconButton.styleFrom(
                              backgroundColor: scheme.error,
                            ),
                            icon: const Icon(Icons.delete_outline),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
