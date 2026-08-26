import 'package:flutter/material.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

/// Same full-width button, with a white flash that does not change layout.
class RefreshBlinkButton extends StatelessWidget {
  const RefreshBlinkButton({
    required this.label,
    required this.isBlinking,
    this.onPressed,
    super.key,
  });

  final String label;
  final bool isBlinking;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FullWidthElevatedButton(label: label, onPressed: onPressed),
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 70),
              opacity: isBlinking ? 0.55 : 0,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
