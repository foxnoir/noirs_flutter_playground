import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/shared_widgets/lab_intro_copy.dart';

void main() {
  test('splitLabIntroParagraphs splits on blank lines', () {
    const body = 'First.\n\nSecond.\n\nThird.';
    expect(splitLabIntroParagraphs(body), ['First.', 'Second.', 'Third.']);
  });

  test('labIntroPieces marks **terms** as bold', () {
    expect(labIntroPieces('Prefer **ConsumerWidget** here.'), [
      ('Prefer ', false),
      ('ConsumerWidget', true),
      (' here.', false),
    ]);
  });

  testWidgets('renders justified paragraphs with bold terms', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LabIntroCopy(
            'Call **invalidate** after save.\n\nSecond paragraph.',
          ),
        ),
      ),
    );

    expect(
      find.text('Call invalidate after save.', findRichText: true),
      findsOneWidget,
    );
    expect(find.text('Second paragraph.', findRichText: true), findsOneWidget);
  });
}
