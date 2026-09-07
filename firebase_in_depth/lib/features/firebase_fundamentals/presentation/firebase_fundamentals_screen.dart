import 'package:firebase_in_depth/core/router/app_router_names.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_devtools_hint.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_lessons_section.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_query_section.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_read_section.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_realtime_section.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:firebase_in_depth/shared_widgets/site_scaffold.dart';
import 'package:flutter/material.dart';

class FirebaseFundamentalsScreen extends StatelessWidget {
  const FirebaseFundamentalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SiteScaffold(
      currentRoute: AppRouteNames.fundamentals,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 48),
        children: [
          Text(
            l10n.fundamentals,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 12),
          FirebaseFundamentalsDevtoolsHint(body: l10n.fundamentalsDevtoolsHint),
          const SizedBox(height: 32),
          const FirebaseFundamentalsReadSection(),
          const SizedBox(height: 32),
          const FirebaseFundamentalsQuerySection(),
          const SizedBox(height: 32),
          const FirebaseFundamentalsLessonsSection(),
          const SizedBox(height: 32),
          const FirebaseFundamentalsRealtimeSection(),
        ],
      ),
    );
  }
}
