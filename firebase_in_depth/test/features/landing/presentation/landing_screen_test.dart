import 'package:firebase_in_depth/features/firebase_fundamentals/presentation/firebase_fundamentals_screen.dart';
import 'package:firebase_in_depth/features/landing/presentation/landing_screen.dart';
import 'package:firebase_in_depth/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Landing is the initial route and lists Firebase Fundamentals', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: FirebaseInDepthApp()));

    expect(find.byType(LandingScreen), findsOneWidget);
    expect(find.text('Firebase Fundamentals'), findsOneWidget);
  });

  testWidgets('Landing navigates to Firebase Fundamentals', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FirebaseInDepthApp()));

    await tester.tap(find.text('Firebase Fundamentals'));
    await tester.pumpAndSettle();

    expect(find.byType(FirebaseFundamentalsScreen), findsOneWidget);
  });
}
