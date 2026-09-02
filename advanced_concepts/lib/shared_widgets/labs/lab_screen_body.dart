import 'package:advanced_concepts/core/theme/theme.dart';
import 'package:flutter/material.dart';

/// Centers [child] and caps width at [AppBreakpoint.contentMax].
///
/// Uses [LayoutBuilder] (parent), not [MediaQuery] (window).
/// Keeps a max height so a [ListView] child still has a viewport.
class LabScreenBody extends StatelessWidget {
  const LabScreenBody({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: AppBreakpoint.contentMax,
              minHeight: constraints.maxHeight,
              maxHeight: constraints.maxHeight,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
