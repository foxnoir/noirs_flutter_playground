import 'package:flutter/material.dart';

class LabCompareFrame extends StatelessWidget {
  const LabCompareFrame({
    required this.ok,
    required this.title,
    required this.hint,
    required this.child,
    super.key,
    this.hintAtTop = false,
  });

  final bool ok;
  final String title;
  final String hint;
  final Widget child;
  final bool hintAtTop;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final border = ok ? scheme.secondary : scheme.error;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  ok ? Icons.check_circle_outline : Icons.error_outline,
                  size: 18,
                  color: border,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.titleSmall?.copyWith(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      color: border,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (hintAtTop) ...[
              Text(
                hint,
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
            ],
            child,
            if (!hintAtTop) ...[
              const SizedBox(height: 8),
              Text(hint, style: textTheme.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}
