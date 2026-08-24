import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/landing_page/presentation/landing_page.dart';
import 'package:riverpod_basics/main.dart';

void main() {
  testWidgets('RiverpodBasicsApp starts on the landing page', (tester) async {
    // ProviderScope creates the ProviderContainer for the widget tree.
    // Without it, ref.watch / ref.read throw.
    await tester.pumpWidget(const ProviderScope(child: RiverpodBasicsApp()));
    await tester.pumpAndSettle();

    expect(find.byType(LandingPage), findsOneWidget);
    expect(find.text('Riverpod Basics'), findsWidgets);
  });
}
