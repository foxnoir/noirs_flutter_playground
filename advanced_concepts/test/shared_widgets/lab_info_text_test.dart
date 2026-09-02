import 'package:advanced_concepts/shared_widgets/labs/lab_info_text.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('labInfoPieces bolds **terms**', () {
    expect(labInfoPieces('go vs **push**.'), [
      ('go vs ', false),
      ('push', true),
      ('.', false),
    ]);
  });

  test('splitLabInfoParagraphs splits on blank lines', () {
    expect(splitLabInfoParagraphs('One.\n\nTwo.'), ['One.', 'Two.']);
  });
}
