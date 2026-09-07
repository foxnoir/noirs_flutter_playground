import 'package:firebase_in_depth/core/theme/app_breakpoint.dart';
import 'package:flutter/material.dart';

/// Two panes from medium width up; stacked below that.
class FirebaseFundamentalsWideSplit extends StatelessWidget {
  const FirebaseFundamentalsWideSplit({
    required this.left,
    required this.right,
    super.key,
  });

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < AppBreakpoint.mediumMin) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [left, const SizedBox(height: 16), right],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: left),
            const SizedBox(width: 16),
            Expanded(child: right),
          ],
        );
      },
    );
  }
}
