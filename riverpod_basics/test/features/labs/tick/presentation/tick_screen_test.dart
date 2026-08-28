import 'dart:async';

import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/tick/data/data_sources/in_memory_tick_data_source.dart';
import 'package:riverpod_basics/features/labs/tick/data/repositories/in_memory_tick_repository.dart';
import 'package:riverpod_basics/features/labs/tick/domain/entities/tick.dart';
import 'package:riverpod_basics/features/labs/tick/presentation/tick_screen.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/error_widget.dart';

import '../fake_tick_repository.dart';

void main() {
  final emittedAt = DateTime(2026, 1, 1, 12, 0, 5);
  final tick = Tick(n: 1, emittedAt: emittedAt);

  Widget app({required FakeTickRepository repository}) {
    return ProviderScope(
      overrides: [tickRepositoryProvider.overrideWithValue(repository)],
      child: const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: TickScreen(),
      ),
    );
  }

  void useTallSurface(WidgetTester tester) {
    tester.view.physicalSize = const Size(800, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  Finder labButton(String label) {
    final key = switch (label) {
      'Start' => const Key('tickStart'),
      'Stop' => const Key('tickStop'),
      'Invalidate' => const Key('tickReload'),
      'Fail call' => const Key('tickFailCall'),
      _ => throw ArgumentError.value(label),
    };
    return find.byKey(key, skipOffstage: false);
  }

  Future<void> tapLabButton(WidgetTester tester, String label) async {
    final button = labButton(label);
    await tester.scrollUntilVisible(button, 80);
    await tester.tap(button);
    await tester.pump();
  }

  testWidgets('shows a spinner then each tick', (tester) async {
    final controller = StreamController<Tick>();
    addTearDown(controller.close);

    await tester.pumpWidget(
      app(repository: FakeTickRepository(stream: controller.stream)),
    );
    await tester.pump();

    expect(
      find.byType(CircularProgressIndicator, skipOffstage: false),
      findsOneWidget,
    );

    controller.add(tick);
    await tester.pump();

    expect(find.textContaining('Tick 1', skipOffstage: false), findsOneWidget);

    controller.add(Tick(n: 2, emittedAt: emittedAt));
    await tester.pump();

    expect(find.textContaining('Tick 2', skipOffstage: false), findsOneWidget);
    expect(find.textContaining('Tick 1', skipOffstage: false), findsNothing);
  });

  testWidgets('maps a stream failure to l10n copy', (tester) async {
    await tester.pumpWidget(
      app(repository: FakeTickRepository(error: const NetworkFailure())),
    );
    await tester.pump();

    expect(
      find.text(
        'Could not reach the server. Check your connection.',
        skipOffstage: false,
      ),
      findsOneWidget,
    );
    expect(find.byType(ErrorWidget, skipOffstage: false), findsOneWidget);
  });

  testWidgets('Fail call shows the network error without invalidate', (
    tester,
  ) async {
    useTallSurface(tester);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tickIntervalProvider.overrideWithValue(
            const Duration(milliseconds: 20),
          ),
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: TickScreen(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 30));

    expect(find.textContaining('Tick 1', skipOffstage: false), findsOneWidget);

    await tapLabButton(tester, 'Fail call');
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('read()'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 30));

    expect(find.byType(ErrorWidget, skipOffstage: false), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(ErrorWidget, skipOffstage: false),
        matching: find.text(
          'Could not reach the server. Check your connection.',
        ),
      ),
      findsOneWidget,
    );

    await tester.pump(const Duration(milliseconds: 1600));
    await tapLabButton(tester, 'Start');
    await tester.pump(const Duration(milliseconds: 30));
    expect(find.textContaining('Tick 1', skipOffstage: false), findsOneWidget);
    expect(find.byType(ErrorWidget, skipOffstage: false), findsNothing);
  });

  testWidgets('Stop unsubscribes; Start watches again at tick 1', (
    tester,
  ) async {
    useTallSurface(tester);
    final repository = FakeTickRepository(ticks: [tick]);
    await tester.pumpWidget(app(repository: repository));
    await tester.pump();

    expect(find.textContaining('Tick 1', skipOffstage: false), findsOneWidget);
    expect(repository.watchCalls, 1);

    await tapLabButton(tester, 'Stop');
    await tester.pump();

    expect(
      find.descendant(
        of: find.byKey(const Key('tickCard'), skipOffstage: false),
        matching: find.text('Stopped.', skipOffstage: false),
      ),
      findsOneWidget,
    );
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('read() → unwatch'), findsOneWidget);
    await tester.pump();
    expect(repository.watchCalls, 1);

    await tapLabButton(tester, 'Start');
    await tester.pump();

    expect(find.text('read() → watch()'), findsOneWidget);
    expect(repository.watchCalls, 2);
  });

  testWidgets('Invalidate starts a new stream at tick 1', (tester) async {
    useTallSurface(tester);
    final repository = FakeTickRepository(ticks: [tick]);
    await tester.pumpWidget(app(repository: repository));
    await tester.pump();

    expect(find.textContaining('Tick 1', skipOffstage: false), findsOneWidget);
    expect(repository.watchCalls, 1);

    await tapLabButton(tester, 'Invalidate');
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('invalidate() → watch()'), findsOneWidget);
    expect(repository.watchCalls, 2);
    expect(find.textContaining('Tick 1', skipOffstage: false), findsOneWidget);
  });
}
