import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/theme/theme.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/providers/lifetimes_keep_alive_provider.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/widgets/keep_alive_snack_bar_listener.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

void main() {
  testWidgets('snackbar shows keep-alive lifecycle for 1.5 seconds', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          locale: const Locale('en'),
          theme: getLightTheme(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: KeepAliveSnackBarListener(
            child: Scaffold(
              body: Consumer(
                builder: (context, ref, _) {
                  return TextButton(
                    onPressed: () {
                      ref
                          .read(keepAliveNoticeProvider.notifier)
                          .emit(KeepAliveLifecycle.resume);
                    },
                    child: const Text('Emit'),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Emit'));
    await tester.pump();
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Keep Alive: onResume (Timer stopped)'), findsOneWidget);
  });
}
