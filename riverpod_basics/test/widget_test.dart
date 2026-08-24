import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/main.dart';

void main() {
  testWidgets('Landing page is the initial route', (tester) async {
    // ProviderScope creates the ProviderContainer for the widget tree.
    // Without it, ref.watch / ref.read throw.
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));

    expect(find.text('No Provider'), findsOneWidget);
    expect(find.text('StateProvider'), findsOneWidget);
    expect(find.text('NotifierProvider'), findsOneWidget);
    expect(find.text('AsyncNotifier Persistent State'), findsOneWidget);
    expect(find.text('AsyncNotifier Non-Persistent State'), findsOneWidget);
  });

  testWidgets('Landing page navigates to StateProvider', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));

    await tester.tap(find.text('StateProvider'));
    // pumpAndSettle waits until go_router / animations finish.
    await tester.pumpAndSettle();

    expect(
      find.text('You have pressed the button this many times: 0'),
      findsOneWidget,
    );

    await tester.tap(find.byIcon(Icons.add));
    // pump() applies one frame. Use it after a tap that only setState / notify.
    await tester.pump();

    expect(
      find.text('You have pressed the button this many times: 1'),
      findsOneWidget,
    );
  });

  testWidgets('Non-Persistent State loads again after back', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));

    await tester.tap(find.text('AsyncNotifier Non-Persistent State'));
    await tester.pump();
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(
      find.text('You have pressed the button this many times: 1'),
      findsOneWidget,
    );

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('AsyncNotifier Non-Persistent State'));
    await tester.pump();
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

    expect(
      find.text('You have pressed the button this many times: 0'),
      findsOneWidget,
    );
  });

  testWidgets('Persistent State keeps count after back', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));

    await tester.tap(find.text('AsyncNotifier Persistent State'));
    await tester.pump();
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(
      find.text('You have pressed the button this many times: 1'),
      findsOneWidget,
    );

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('AsyncNotifier Persistent State'));
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(
      find.text('You have pressed the button this many times: 1'),
      findsOneWidget,
    );
  });
}
