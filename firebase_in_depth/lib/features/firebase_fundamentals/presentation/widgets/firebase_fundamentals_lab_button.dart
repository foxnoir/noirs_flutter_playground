import 'package:flutter/material.dart';

/// Compact lab action. Teal when the query is expected to work, error
/// rose when it is expected to fail. Width follows the label, not the
/// parent.
class FirebaseFundamentalsLabButton extends StatelessWidget {
  const FirebaseFundamentalsLabButton({
    required this.valid,
    required this.onPressed,
    required this.label,
    super.key,
  });

  final bool valid;
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: valid ? scheme.secondary : scheme.error,
        foregroundColor: valid ? scheme.onSecondary : scheme.onError,
      ),
      child: Text(label),
    );
  }
}
