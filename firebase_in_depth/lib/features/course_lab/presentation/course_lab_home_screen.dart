import 'package:firebase_in_depth/core/router/app_router_names.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/widgets/course_lab_track_links.dart';
import 'package:firebase_in_depth/features/course_lab/presentation/widgets/course_lab_track_panel.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:firebase_in_depth/shared_widgets/site_scaffold.dart';
import 'package:flutter/material.dart';

class CourseLabHomeScreen extends StatefulWidget {
  const CourseLabHomeScreen({super.key});

  @override
  State<CourseLabHomeScreen> createState() => _CourseLabHomeScreenState();
}

class _CourseLabHomeScreenState extends State<CourseLabHomeScreen> {
  final _pages = PageController();
  var _track = CourseLabTrack.beginner;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _select(CourseLabTrack track) {
    if (track == _track) return;
    _pages.animateToPage(
      track.index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SiteScaffold(
      currentRoute: AppRouteNames.home,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.courseLab,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 20),
            CourseLabTrackLinks(track: _track, onChanged: _select),
            const SizedBox(height: 20),
            Expanded(
              child: PageView(
                key: const Key('course-lab-pages'),
                controller: _pages,
                onPageChanged: (index) {
                  setState(() => _track = CourseLabTrack.values[index]);
                },
                children: [
                  for (final track in CourseLabTrack.values)
                    CourseLabTrackPanel(
                      key: Key('course-lab-panel-${track.name}'),
                      track: track,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
