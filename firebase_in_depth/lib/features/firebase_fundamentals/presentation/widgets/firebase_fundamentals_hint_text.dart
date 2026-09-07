import 'package:flutter/material.dart';

/// Lab copy with `**bold**` and `` `code` ``, same markers as the README.
class FirebaseFundamentalsHintText extends StatelessWidget {
  const FirebaseFundamentalsHintText({
    required this.text,
    this.style,
    super.key,
  });

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final base = style ?? Theme.of(context).textTheme.bodySmall;
    return Text.rich(TextSpan(style: base, children: hintSpans(text, base)));
  }
}

List<InlineSpan> hintSpans(String text, TextStyle? base) {
  final bold = base?.copyWith(fontWeight: FontWeight.w700);
  final code = base?.copyWith(fontFamily: 'monospace');
  final spans = <InlineSpan>[];
  final pattern = RegExp(r'\*\*(.+?)\*\*|`([^`]+)`');
  var start = 0;
  for (final match in pattern.allMatches(text)) {
    if (match.start > start) {
      spans.add(TextSpan(text: text.substring(start, match.start)));
    }
    final boldText = match.group(1);
    if (boldText != null) {
      spans.add(TextSpan(text: boldText, style: bold));
    } else {
      spans.add(TextSpan(text: match.group(2), style: code));
    }
    start = match.end;
  }
  if (start < text.length) {
    spans.add(TextSpan(text: text.substring(start)));
  }
  return spans;
}
