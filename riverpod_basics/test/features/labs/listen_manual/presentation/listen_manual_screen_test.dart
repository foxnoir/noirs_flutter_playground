import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/theme/theme.dart';
import 'package:riverpod_basics/features/labs/listen_manual/presentation/listen_manual_screen.dart';
import 'package:riverpod_basics/features/labs/listen_manual/presentation/providers/listen_manual_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

void main() {
  Widget listenManualApp({ListenManualNotifier Function()? createNotifier}) {
    return ProviderScope(
      overrides: [
        if (createNotifier != null)
          listenManualErrorProvider.overrideWith(createNotifier),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        theme: getLightTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const ListenManualScreen(),
      ),
    );
  }

  testWidgets('ListenManualScreen shows a dialog when an error is stored', (
    tester,
  ) async {
    await tester.pumpWidget(listenManualApp());

    expect(find.text('watch'), findsOneWidget);
    expect(find.text('read'), findsOneWidget);
    expect(find.text('listenManual'), findsOneWidget);
    expect(find.text('listen'), findsOneWidget);
    expect(find.text('Live value. Empty now.'), findsOneWidget);

    await tester.tap(
      find.widgetWithText(FullWidthElevatedButton, 'Store an error'),
    );
    await tester.pumpAndSettle();

    expect(find.text('Error'), findsOneWidget);
    expect(
      find.text('Could not load. This stays until you tap Clear error.'),
      findsOneWidget,
    );
    expect(find.text('Live value. Filled — survives Back.'), findsOneWidget);
    expect(
      find.text('Snapshot at open: null. Store will not change this.'),
      findsOneWidget,
    );
    expect(find.text('No stored error on open.'), findsOneWidget);
    expect(find.text('Saw a change this visit.'), findsOneWidget);
    expect(find.text('listen: the value changed.'), findsOneWidget);
  });

  testWidgets(
    'ListenManualScreen shows a dialog for an error that is already set',
    (tester) async {
      await tester.pumpWidget(
        listenManualApp(createNotifier: _SeededListenManualNotifier.new),
      );
      await tester.pumpAndSettle();

      expect(find.text('Error'), findsOneWidget);
      expect(
        find.text('Could not load. This stays until you tap Clear error.'),
        findsOneWidget,
      );
      expect(
        find.text('Ran on open — error was already stored.'),
        findsOneWidget,
      );
      expect(
        find.text('Snapshot at open: stored error. initState ran again.'),
        findsOneWidget,
      );
      expect(find.text('No change this visit.'), findsOneWidget);
      expect(find.text('listen: the value changed.'), findsNothing);
    },
  );
}

class _SeededListenManualNotifier extends ListenManualNotifier {
  @override
  String? build() => listenManualFetchError;
}
