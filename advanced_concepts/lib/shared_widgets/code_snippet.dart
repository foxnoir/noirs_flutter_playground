import 'package:flutter/material.dart';

class CodeSnippet extends StatelessWidget {
  const CodeSnippet(this.text, {super.key, this.maxLines});

  final String text;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final base = DefaultTextStyle.of(context).style;

    return Text(
      text,
      maxLines: maxLines,
      overflow: maxLines == null ? TextOverflow.visible : TextOverflow.ellipsis,
      style: base.copyWith(fontFamily: 'monospace', fontSize: 12, height: 1.35),
    );
  }
}
