import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_devtools_hint.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_lessons_section.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_query_section.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_read_section.dart';
import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_realtime_section.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FirebaseFundamentalsScreen extends StatelessWidget {
  const FirebaseFundamentalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.fundamentals)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FirebaseFundamentalsDevtoolsHint(body: l10n.fundamentalsDevtoolsHint),
          const SizedBox(height: 24),
          const FirebaseFundamentalsReadSection(),
          const SizedBox(height: 24),
          const FirebaseFundamentalsQuerySection(),
          const SizedBox(height: 24),
          const FirebaseFundamentalsLessonsSection(),
          const SizedBox(height: 24),
          const FirebaseFundamentalsRealtimeSection(),
        ],
      ),
    );
  }
}
