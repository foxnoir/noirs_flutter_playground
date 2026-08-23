import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basic_starter/main.dart';

void main() {
  testWidgets('Home is the initial route', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: RiverpodBasicStarterApp()),
    );

    expect(find.text('One'), findsOneWidget);
    expect(find.text('Two'), findsOneWidget);
    expect(find.text('Three'), findsOneWidget);
  });

  testWidgets('Home navigates to One', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: RiverpodBasicStarterApp()),
    );

    await tester.tap(find.text('One'));
    await tester.pumpAndSettle();

    expect(find.text('Page'), findsOneWidget);
  });
}
