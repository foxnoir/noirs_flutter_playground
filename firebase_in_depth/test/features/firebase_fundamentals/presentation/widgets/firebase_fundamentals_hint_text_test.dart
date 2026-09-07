import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/widgets/firebase_fundamentals_hint_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('hintSpans marks bold and code', () {
    final spans = hintSpans(
      'Open **DevTools** and filter `firestore`.',
      const TextStyle(),
    );

    expect(spans, hasLength(5));
    expect((spans[0] as TextSpan).text, 'Open ');
    expect((spans[1] as TextSpan).text, 'DevTools');
    expect((spans[1] as TextSpan).style?.fontWeight, FontWeight.w700);
    expect((spans[2] as TextSpan).text, ' and filter ');
    expect((spans[3] as TextSpan).text, 'firestore');
    expect((spans[3] as TextSpan).style?.fontFamily, 'monospace');
    expect((spans[4] as TextSpan).text, '.');
  });
}
