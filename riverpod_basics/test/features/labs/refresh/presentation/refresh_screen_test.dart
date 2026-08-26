import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/theme/theme.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/providers/refresh_provider.dart';
import 'package:riverpod_basics/features/labs/refresh/presentation/refresh_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

void main() {
  Widget refreshApp() {
    return ProviderScope(
      overrides: [refreshPingDelayProvider.overrideWith((_) => Duration.zero)],
      child: MaterialApp(
        locale: const Locale('en'),
        theme: getLightTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const RefreshScreen(),
      ),
    );
  }

  testWidgets('shows the last fetch time after the first GET', (tester) async {
    await tester.pumpWidget(refreshApp());
    await tester.pumpAndSettle();

    expect(find.text('watch'), findsOneWidget);
    expect(find.textContaining('Last fetch:'), findsOneWidget);
  });

  testWidgets('Refresh runs the GET again', (tester) async {
    await tester.pumpWidget(refreshApp());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FullWidthElevatedButton, 'Refresh'));
    await tester.pump();

    expect(find.text('Loading…'), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.textContaining('Last fetch:'), findsOneWidget);
  });

  testWidgets('Invalidate runs the GET again', (tester) async {
    await tester.pumpWidget(refreshApp());
    await tester.pumpAndSettle();

    await tester.tap(
      find.widgetWithText(FullWidthElevatedButton, 'Invalidate'),
    );
    await tester.pump();

    expect(find.text('Loading…'), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.textContaining('Last fetch:'), findsOneWidget);
  });
}
