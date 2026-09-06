import 'package:firebase_in_depth/core/router/page_not_found_screen.dart';
import 'package:firebase_in_depth/features/landing/presentation/landing_screen.dart';
import 'package:firebase_in_depth/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('Unknown path shows PageNotFoundScreen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FirebaseInDepthApp()));

    final context = tester.element(find.byType(LandingScreen));
    GoRouter.of(context).go('/does-not-exist');
    await tester.pumpAndSettle();

    expect(find.byType(PageNotFoundScreen), findsOneWidget);
    expect(find.text('Missing'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
  });
}
