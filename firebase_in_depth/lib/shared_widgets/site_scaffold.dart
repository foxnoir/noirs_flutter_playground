import 'package:firebase_in_depth/core/theme/app_breakpoint.dart';
import 'package:firebase_in_depth/shared_widgets/app_background.dart';
import 'package:firebase_in_depth/shared_widgets/site_header.dart';
import 'package:flutter/material.dart';

/// Website chrome: top nav, `bg.webp`, capped content width.
class SiteScaffold extends StatelessWidget {
  const SiteScaffold({required this.body, this.currentRoute, super.key});

  final Widget body;
  final String? currentRoute;

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SiteHeader(currentRoute: currentRoute),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: AppBreakpoint.contentMax,
                    ),
                    child: body,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
