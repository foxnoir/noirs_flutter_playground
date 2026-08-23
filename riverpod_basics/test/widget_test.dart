import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/main.dart';

void main() {
  testWidgets('Landing page is the initial route', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));

    expect(find.text('StateProvider'), findsOneWidget);
    expect(find.text('Provider 2'), findsOneWidget);
    expect(find.text('Provider 3'), findsOneWidget);
  });

  testWidgets('Landing page navigates to StateProvider', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));

    await tester.tap(find.text('StateProvider'));
    await tester.pumpAndSettle();

    expect(find.text('Counter'), findsOneWidget);
  });
}
