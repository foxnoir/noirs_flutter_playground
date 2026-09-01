import 'package:advanced_concepts/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CodeSnippet extends StatelessWidget {
  const CodeSnippet(this.text, {super.key, this.maxLines});

  final String text;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: maxLines == null ? TextOverflow.visible : TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.code,
    );
  }
}
