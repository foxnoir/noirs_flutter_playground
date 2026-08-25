import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/provider_lifetimes/presentation/provider_lifetimes_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

void main() {
  const persistentSection = Key('lifetimes-persistent');
  const nonPersistentSection = Key('lifetimes-non-persistent');
  const keepAliveSection = Key('lifetimes-keep-alive');

  Finder fieldIn(Key section) {
    return find.descendant(
      of: find.byKey(section),
      matching: find.byType(TextFormField),
    );
  }

  Finder addButtonIn(Key section) {
    return find.descendant(of: find.byKey(section), matching: find.text('Add'));
  }

  Finder userValueIn(Key section, String name) {
    return find.descendant(
      of: find.byKey(section),
      matching: find.text('User: $name'),
    );
  }

  testWidgets(
    'ProviderLifetimesScreen updates persistent, non-persistent, and keep-alive users independently',
    (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            locale: Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ProviderLifetimesScreen(),
          ),
        ),
      );

      expect(find.widgetWithText(AppBar, 'Provider Lifetimes'), findsOneWidget);
      expect(find.text('Persistent'), findsOneWidget);
      expect(find.text('Non-Persistent'), findsOneWidget);
      expect(find.text('Keep Alive 5 Seconds'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Username'), findsNWidgets(3));
      expect(find.byType(FullWidthElevatedButton), findsNWidgets(3));
      expect(userValueIn(persistentSection, '-'), findsOneWidget);
      expect(userValueIn(nonPersistentSection, '-'), findsOneWidget);
      expect(userValueIn(keepAliveSection, '-'), findsOneWidget);

      await tester.enterText(fieldIn(persistentSection), 'Ada');
      await tester.tap(addButtonIn(persistentSection));
      await tester.pump();

      expect(userValueIn(persistentSection, 'Ada'), findsOneWidget);
      expect(userValueIn(nonPersistentSection, '-'), findsOneWidget);
      expect(userValueIn(keepAliveSection, '-'), findsOneWidget);

      await tester.enterText(fieldIn(nonPersistentSection), 'Bob');
      await tester.tap(addButtonIn(nonPersistentSection));
      await tester.pump();

      expect(userValueIn(persistentSection, 'Ada'), findsOneWidget);
      expect(userValueIn(nonPersistentSection, 'Bob'), findsOneWidget);
      expect(userValueIn(keepAliveSection, '-'), findsOneWidget);

      await tester.enterText(fieldIn(keepAliveSection), 'Cyd');
      await tester.tap(addButtonIn(keepAliveSection));
      await tester.pump();

      expect(userValueIn(persistentSection, 'Ada'), findsOneWidget);
      expect(userValueIn(nonPersistentSection, 'Bob'), findsOneWidget);
      expect(userValueIn(keepAliveSection, 'Cyd'), findsOneWidget);
    },
  );
}
