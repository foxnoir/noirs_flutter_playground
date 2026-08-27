import 'package:flutter/material.dart';

class QuoteResultCard extends StatelessWidget {
  const QuoteResultCard({
    required this.label,
    required this.background,
    required this.foreground,
    required this.isLoading,
    this.text,
    this.author,
    super.key,
  });

  final String label;
  final Color background;
  final Color foreground;
  final bool isLoading;
  final String? text;
  final String? author;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: textTheme.labelLarge?.copyWith(
                color: foreground,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else ...[
              Text(
                text ?? '',
                style: textTheme.bodyLarge?.copyWith(
                  color: foreground,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                author ?? '',
                style: textTheme.bodyMedium?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
