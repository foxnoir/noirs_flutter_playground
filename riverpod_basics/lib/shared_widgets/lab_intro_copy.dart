import 'package:flutter/material.dart';

/// Split lab intro copy into paragraphs (`\n\n`).
List<String> splitLabIntroParagraphs(String body) {
  return body
      .split('\n\n')
      .map((paragraph) => paragraph.trim())
      .where((paragraph) => paragraph.isNotEmpty)
      .toList();
}

/// Pieces of a paragraph. `**word**` in the ARB becomes bold.
List<(String text, bool bold)> labIntroPieces(String paragraph) {
  final pieces = <(String, bool)>[];
  var rest = paragraph;
  while (true) {
    final start = rest.indexOf('**');
    if (start < 0) {
      if (rest.isNotEmpty) pieces.add((rest, false));
      return pieces;
    }
    if (start > 0) {
      pieces.add((rest.substring(0, start), false));
    }
    rest = rest.substring(start + 2);
    final end = rest.indexOf('**');
    if (end < 0) {
      pieces.add((rest, false));
      return pieces;
    }
    pieces.add((rest.substring(0, end), true));
    rest = rest.substring(end + 2);
  }
}

/// Justified lab intro with paragraphs and `**bold**` terms.
class LabIntroCopy extends StatelessWidget {
  const LabIntroCopy(this.body, {super.key});

  final String body;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium;
    final bold = style?.copyWith(fontWeight: FontWeight.w700);
    final paragraphs = splitLabIntroParagraphs(body);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < paragraphs.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              children: [
                for (final piece in labIntroPieces(paragraphs[i]))
                  TextSpan(text: piece.$1, style: piece.$2 ? bold : style),
              ],
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ],
    );
  }
}
