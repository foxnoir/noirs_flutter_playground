import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/quote/data/data_sources/in_memory_quote_data_source.dart';
import 'package:riverpod_basics/features/labs/quote/data/repositories/in_memory_quote_repository.dart';
import 'package:riverpod_basics/features/labs/quote/domain/entities/quote.dart';
import 'package:riverpod_basics/features/labs/quote/presentation/providers/quote_provider.dart';
import 'package:riverpod_basics/features/labs/quote/presentation/quote_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/error_widget.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

import '../fake_quote_repository.dart';

void main() {
  const quote = Quote(text: 'Hello', author: 'Ada');

  Widget app({
    required FakeQuoteRepository repository,
    Duration delay = Duration.zero,
  }) {
    return ProviderScope(
      overrides: [
        quoteRepositoryProvider.overrideWithValue(repository),
        quoteDelayProvider.overrideWithValue(delay),
      ],
      child: const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: QuoteScreen(),
      ),
    );
  }

  Finder labButton(String label) {
    return find.widgetWithText(
      FullWidthElevatedButton,
      label,
      skipOffstage: false,
    );
  }

  Future<void> tapLabButton(WidgetTester tester, String label) async {
    await tester.scrollUntilVisible(labButton(label), 80);
    await tester.pumpAndSettle();
    await tester.tap(labButton(label));
  }

  testWidgets('shows a spinner then the quote', (tester) async {
    await tester.pumpWidget(
      app(
        repository: const FakeQuoteRepository(quote: quote),
        delay: const Duration(milliseconds: 50),
      ),
    );
    await tester.pump();

    expect(
      find.byType(CircularProgressIndicator, skipOffstage: false),
      findsNWidgets(2),
    );

    await tester.pumpAndSettle();

    expect(find.text(quote.text, skipOffstage: false), findsNWidgets(2));
    expect(find.text(quote.author, skipOffstage: false), findsNWidgets(2));
  });

  testWidgets('maps a fetch failure to l10n copy', (tester) async {
    await tester.pumpWidget(
      app(repository: const FakeQuoteRepository(error: NetworkFailure())),
    );
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Could not reach the server. Check your connection.',
        skipOffstage: false,
      ),
      findsNWidgets(2),
    );
    expect(find.byType(ErrorWidget, skipOffstage: false), findsNWidgets(2));
  });

  testWidgets('Fail call shows the network error on FutureProvider only', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [quoteDelayProvider.overrideWithValue(Duration.zero)],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: QuoteScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Lewis Carroll', skipOffstage: false), findsNWidgets(2));

    await tapLabButton(tester, 'Fail call');
    await tester.pumpAndSettle();

    expect(
      find.descendant(
        of: find.byKey(const Key('quoteNoInputCard'), skipOffstage: false),
        matching: find.byType(ErrorWidget, skipOffstage: false),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const Key('quoteFromInputCard'), skipOffstage: false),
        matching: find.byType(ErrorWidget, skipOffstage: false),
      ),
      findsNothing,
    );
    expect(find.text('Lewis Carroll', skipOffstage: false), findsOneWidget);
  });

  testWidgets('Increment number re-runs only FutureProvider + input', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [quoteDelayProvider.overrideWithValue(Duration.zero)],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: QuoteScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    String quoteOn(Key key) {
      return InMemoryQuoteDataSource.quotes
          .map((quote) => quote.text)
          .firstWhere(
            (text) => find
                .descendant(
                  of: find.byKey(key, skipOffstage: false),
                  matching: find.text(text, skipOffstage: false),
                )
                .evaluate()
                .isNotEmpty,
          );
    }

    const noInput = Key('quoteNoInputCard');
    const fromInput = Key('quoteFromInputCard');
    final noInputBefore = quoteOn(noInput);
    final fromInputBefore = quoteOn(fromInput);

    await tapLabButton(tester, 'Increment number');
    await tester.pumpAndSettle();

    expect(quoteOn(noInput), noInputBefore);
    expect(quoteOn(fromInput), isNot(fromInputBefore));
    expect(find.text('Lewis Carroll', skipOffstage: false), findsNWidgets(2));
  });
}
