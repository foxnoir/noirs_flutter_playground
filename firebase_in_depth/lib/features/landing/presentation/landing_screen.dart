import 'package:firebase_in_depth/core/router/app_router_names.dart';
import 'package:firebase_in_depth/core/theme/app_breakpoint.dart';
import 'package:firebase_in_depth/features/landing/presentation/widgets/landing_card.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:firebase_in_depth/shared_widgets/site_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return SiteScaffold(
      currentRoute: AppRouteNames.landing,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= AppBreakpoint.mediumMin;
          final cards = [
            LandingCard(
              key: const Key('landing-fundamentals'),
              title: l10n.fundamentals,
              body: l10n.fundamentalsCardBody,
              onTap: () => context.goNamed(AppRouteNames.fundamentals),
            ),
            LandingCard(
              key: const Key('landing-course-lab'),
              title: l10n.courseLab,
              body: l10n.courseLabCardBody,
              onTap: () => context.goNamed(AppRouteNames.home),
            ),
          ];

          return ListView(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 48),
            children: [
              Text(l10n.landingHeadline, style: textTheme.displaySmall),
              const SizedBox(height: 12),
              Text(
                l10n.landingLead,
                style: textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              if (wide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: cards[0]),
                    const SizedBox(width: 16),
                    Expanded(child: cards[1]),
                  ],
                )
              else ...[
                cards[0],
                const SizedBox(height: 16),
                cards[1],
              ],
            ],
          );
        },
      ),
    );
  }
}
