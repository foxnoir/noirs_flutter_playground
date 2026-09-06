import 'package:advanced_concepts/core/router/app_router_calls.dart';
import 'package:advanced_concepts/features/api_compare_lab/presentation/api_compare_lab_screen.dart';
import 'package:advanced_concepts/features/api_dio_lab/data/repositories/api_dio_lab_repository.dart';
import 'package:advanced_concepts/features/api_dio_lab/presentation/api_dio_lab_screen.dart';
import 'package:advanced_concepts/features/api_general_lab/presentation/api_general_lab_screen.dart';
import 'package:advanced_concepts/features/api_handling/presentation/api_handling_screen.dart';
import 'package:advanced_concepts/features/api_http_lab/data/repositories/api_http_lab_repository.dart';
import 'package:advanced_concepts/features/api_http_lab/presentation/api_http_lab_screen.dart';
import 'package:advanced_concepts/features/generics_example_lab/presentation/generics_example_lab_screen.dart';
import 'package:advanced_concepts/features/generics_general_lab/presentation/generics_general_lab_screen.dart';
import 'package:advanced_concepts/features/generics_lab/generics_lab_screen.dart';
import 'package:advanced_concepts/features/landing/presentation/landing_screen.dart';
import 'package:advanced_concepts/features/layout_lab/presentation/layout_lab_screen.dart';
import 'package:advanced_concepts/features/lists_lab/presentation/lists_lab_screen.dart';
import 'package:advanced_concepts/features/mixins_lab/presentation/mixins_lab_screen.dart';
import 'package:advanced_concepts/features/routing_lab/presentation/routing_lab_screen.dart';
import 'package:advanced_concepts/features/sealed_lab/presentation/sealed_lab_screen.dart';
import 'package:advanced_concepts/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../api_dio_lab/fake_api_dio_lab_repository.dart';
import '../../api_http_lab/fake_api_http_lab_repository.dart';

void _useTallSurface(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> _openRoutingLab(WidgetTester tester) async {
  await tester.tap(find.text('Navigation'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Landing Screen lists Navigation and opens Routing Lab', (
    tester,
  ) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    expect(find.byType(LandingScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Advanced Concepts'), findsOneWidget);
    expect(find.text('Navigation'), findsOneWidget);
    expect(find.text('Layout'), findsOneWidget);
    expect(find.text('Lists'), findsOneWidget);
    expect(find.text('API Handling'), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Navigation'), findsNothing);

    await _openRoutingLab(tester);

    expect(find.byType(RoutingLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Navigation'), findsOneWidget);
    expect(find.text(AppRouterCalls.go), findsOneWidget);
    expect(find.text(AppRouterCalls.goNamed), findsOneWidget);
    expect(find.text(AppRouterCalls.push), findsOneWidget);
    expect(find.text(AppRouterCalls.pushNamed), findsOneWidget);
    expect(find.text(AppRouterCalls.goViaRouter), findsOneWidget);
    expect(find.text(AppRouterCalls.pushNamedViaRouter), findsOneWidget);
    expect(find.text(AppRouterCalls.pop), findsOneWidget);
    expect(find.text(AppRouterCalls.replaceNamed), findsOneWidget);
  });

  testWidgets('Landing Layout tile opens Layout Lab', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    await tester.tap(find.text('Layout'));
    await tester.pumpAndSettle();

    expect(find.byType(LayoutLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Layout'), findsOneWidget);
  });

  testWidgets('Landing Mixins tile opens Mixins Lab', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    await tester.tap(find.text('Mixins'));
    await tester.pumpAndSettle();

    expect(find.byType(MixinsLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Mixins'), findsOneWidget);
  });

  testWidgets('Landing Sealed tile opens Sealed Lab', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    expect(find.text(' (plus extends)'), findsOneWidget);

    await tester.tap(find.text('Sealed'));
    await tester.pumpAndSettle();

    expect(find.byType(SealedLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Sealed'), findsOneWidget);
  });

  testWidgets('Landing Generics tile opens Generics Lab', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    await tester.tap(find.text('Generics'));
    await tester.pumpAndSettle();

    expect(find.byType(GenericsLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Generics'), findsOneWidget);
    expect(find.text('General'), findsOneWidget);
    expect(find.text('Example'), findsOneWidget);
  });

  testWidgets('Generics General tile opens General Lab', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    await tester.tap(find.text('Generics'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('General'));
    await tester.pumpAndSettle();

    expect(find.byType(GenericsGeneralLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'General'), findsOneWidget);
  });

  testWidgets('Generics Example tile opens Example Lab', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    await tester.tap(find.text('Generics'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Example'));
    await tester.pumpAndSettle();

    expect(find.byType(GenericsExampleLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Example'), findsOneWidget);
    expect(find.text('Ada'), findsOneWidget);
  });

  testWidgets('Landing Lists tile opens Lists Lab', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    await tester.tap(find.text('Lists'));
    await tester.pumpAndSettle();

    expect(find.byType(ListsLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Lists'), findsOneWidget);
  });

  testWidgets('Landing API Handling tile opens API hub', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    await tester.tap(find.text('API Handling'));
    await tester.pumpAndSettle();

    expect(find.byType(ApiHandlingScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'API Handling'), findsOneWidget);
    expect(find.text('General'), findsOneWidget);
    expect(find.text('HTTP vs Dio'), findsOneWidget);
    expect(find.text('Example HTTP'), findsOneWidget);
    expect(find.text('Example Dio'), findsOneWidget);
  });

  testWidgets('API Handling General tile opens General Lab', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    await tester.tap(find.text('API Handling'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('General'));
    await tester.pumpAndSettle();

    expect(find.byType(ApiGeneralLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'General'), findsOneWidget);
  });

  testWidgets('API Handling HTTP vs Dio tile opens Compare Lab', (
    tester,
  ) async {
    _useTallSurface(tester);
    await tester.pumpWidget(const ProviderScope(child: AdvancedConceptsApp()));

    await tester.tap(find.text('API Handling'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('HTTP vs Dio'));
    await tester.tap(find.text('HTTP vs Dio'));
    await tester.pumpAndSettle();

    expect(find.byType(ApiCompareLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'HTTP vs Dio'), findsOneWidget);
  });

  testWidgets('API Handling Example HTTP tile opens HTTP Lab', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          apiHttpLabRepositoryProvider.overrideWithValue(
            FakeApiHttpLabRepository(),
          ),
        ],
        child: const AdvancedConceptsApp(),
      ),
    );

    await tester.tap(find.text('API Handling'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Example HTTP'));
    await tester.tap(find.text('Example HTTP'));
    await tester.pumpAndSettle();

    expect(find.byType(ApiHttpLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Example HTTP'), findsOneWidget);
  });

  testWidgets('API Handling Example Dio tile opens Dio Lab', (tester) async {
    _useTallSurface(tester);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          apiDioLabRepositoryProvider.overrideWithValue(
            FakeApiDioLabRepository(),
          ),
        ],
        child: const AdvancedConceptsApp(),
      ),
    );

    await tester.tap(find.text('API Handling'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Example Dio'));
    await tester.tap(find.text('Example Dio'));
    await tester.pumpAndSettle();

    expect(find.byType(ApiDioLabScreen), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Example Dio'), findsOneWidget);
  });
}
