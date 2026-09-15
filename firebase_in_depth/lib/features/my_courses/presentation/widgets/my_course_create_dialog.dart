import 'package:firebase_in_depth/core/errors/app_failure_message.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/widgets/course_lab_track_links.dart';
import 'package:firebase_in_depth/features/my_courses/presentation/providers/my_courses_provider.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:firebase_in_depth/shared_widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showMyCourseCreateDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => const MyCourseCreateDialog(),
  );
}

class MyCourseCreateDialog extends ConsumerStatefulWidget {
  const MyCourseCreateDialog({super.key});

  @override
  ConsumerState<MyCourseCreateDialog> createState() =>
      _MyCourseCreateDialogState();
}

class _MyCourseCreateDialogState extends ConsumerState<MyCourseCreateDialog> {
  final _title = TextEditingController();
  final _body = TextEditingController();
  CourseLabTrack _track = CourseLabTrack.beginner;
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final canSave = _title.text.trim().isNotEmpty && !_submitting;

    return AlertDialog(
      key: const Key('my-courses-create-dialog'),
      title: Text(l10n.myCoursesCreateTitle),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              key: const Key('my-courses-create-description'),
              controller: _title,
              enabled: !_submitting,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: l10n.myCoursesCreateName),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('my-courses-create-long-description'),
              controller: _body,
              enabled: !_submitting,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: l10n.myCoursesCreateSummary,
              ),
            ),
            const SizedBox(height: 12),
            DropdownMenu<CourseLabTrack>(
              key: const Key('my-courses-create-track'),
              initialSelection: _track,
              enabled: !_submitting,
              expandedInsets: EdgeInsets.zero,
              label: Text(l10n.myCoursesCreateTrack),
              onSelected: _submitting
                  ? null
                  : (value) {
                      if (value == null) return;
                      setState(() => _track = value);
                    },
              dropdownMenuEntries: [
                for (final track in CourseLabTrack.values)
                  DropdownMenuEntry(value: track, label: track.label(l10n)),
              ],
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(
                _error!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          key: const Key('my-courses-create-cancel'),
          onPressed: _submitting ? null : () => Navigator.of(context).pop(),
          child: Text(l10n.myCoursesCreateCancel),
        ),
        GradientButton(
          key: const Key('my-courses-create-save'),
          label: l10n.myCoursesCreateSave,
          compact: true,
          onPressed: canSave ? _save : null,
        ),
      ],
    );
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(myCoursesProvider.notifier)
          .createCourse(
            description: _title.text,
            longDescription: _body.text,
            category: _track.category,
          );
      if (!mounted) return;
      Navigator.of(context).pop();
    } on Object catch (error) {
      if (!mounted) return;
      setState(() {
        _submitting = false;
        _error = localizedError(l10n, error);
      });
    }
  }
}
