<a name="readme-top"></a>

<!-- Top Links Bar -->

<a href="#test-coverage"><img align="right" src="assets/coverage/badge.svg" alt="Coverage"></a>

[![LinkedIn](../assets/badges/linkedin.svg)](https://www.linkedin.com/in/tanja-polz-5636401a5/)
[![X](../assets/badges/x.svg)](https://twitter.com/_foxnoir_?lang=de)
[![Instagram](../assets/badges/instagram.svg)](https://www.instagram.com/codeincouture/)

<!-- PROJECT LOGO -->
<br />

<div align="center">
  <img src="../assets/logo.png" alt="Logo" width="179" height="179">
  <h1 align="center">Riverpod Basics</h1>
  <p>
     Practice project for Riverpod: NotifierProvider, AsyncNotifier Persistent / Non-Persistent State, and StateProvider as the shortcut.
  </p>
  <p>
    <sub>Inspired by <a href="https://github.com/rddewan">Richard Dewan</a>’s <a href="https://www.udemy.com/course/flutter-riverpod-for-complete-beginner/">Udemy course</a>.</sub>
  </p>
</div>

---

<div align="left">

[![Flutter](../assets/badges/flutter.svg)](https://flutter.dev/)
[![Dart](../assets/badges/dart.svg)](https://dart.dev/)
[![Riverpod](../assets/badges/riverpod.svg)](https://pub.dev/packages/flutter_riverpod)
[![GoRouter](../assets/badges/gorouter.svg)](https://pub.dev/packages/go_router)
[![Flutter Localizations](../assets/badges/flutter_localizations.svg)](https://docs.flutter.dev/ui/internationalization)
[![Intl](../assets/badges/intl.svg)](https://pub.dev/packages/intl)
[![Very Good Analysis](../assets/badges/very_good.svg)](https://pub.dev/packages/very_good_analysis)
[![FVM](../assets/badges/fvm.svg)](https://fvm.app)
[![iOS](../assets/badges/ios.svg)](https://developer.apple.com/ios/)

</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about">About</a></li>
    <li>
      <a href="#riverpod">Riverpod</a>
      <ul>
        <li><a href="#what-is-riverpod">What is Riverpod</a></li>
        <li><a href="#why-riverpod">Why Riverpod</a></li>
        <li><a href="#watch-read-listen">watch, read, listen</a></li>
      </ul>
    </li>
    <li>
      <a href="#providers">Providers</a>
      <ul>
        <li><a href="#no-provider">No provider</a></li>
        <li><a href="#notifierprovider">NotifierProvider</a></li>
        <li><a href="#asyncnotifier-persistent-state">AsyncNotifier Persistent State</a></li>
        <li><a href="#asyncnotifier-non-persistent-state">AsyncNotifier Non-Persistent State</a></li>
        <li><a href="#stateprovider">StateProvider</a></li>
        <li><a href="#how-they-connect">How they connect</a></li>
      </ul>
    </li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li>
      <a href="#testing">Testing</a>
      <ul>
        <li><a href="#testing-in-flutter">Testing in Flutter</a></li>
        <li><a href="#testing-riverpod">Testing Riverpod</a></li>
        <li><a href="#test-coverage">Test coverage</a></li>
      </ul>
    </li>
    <li><a href="#changelog">Changelog</a></li>
    <li><a href="#sources">Sources</a></li>
  </ol>
</details>

---

## About

This app is the **Riverpod** practice project in [Noir's Flutter Playground](../README.md).

The first lesson is the same button-press counter five ways. `NotifierProvider` is the real mutable type. `AsyncNotifierProvider` is that type when the value comes from a `Future`. **Persistent State** keeps the count when you leave the page (plain provider, in memory for the app). **Non-Persistent State** is the same class plus `.autoDispose` — not disk, not a cache. Back to landing drops the last watcher, Riverpod disposes the notifier, next visit loads from zero. `StateProvider` is a tiny notifier whose only API is “set `state`”. Local `setState` stays in the widget.

The landing page is two `ExpansionTile`s: **Providers** (the five counters) and **Scenarios**. Both use `LandingPageDropdown`. The first scenario is a dummy **Current User** screen (`features/scenarios/current_user/`) — one username field and a placeholder value, no provider, empty Add. That name stays distinct from later User List, User Detail, and Stream User screens. Scenarios 2 and 3 are `ScenarioPlaceholderScreen`. Section titles use `textTheme.titleLarge` (`AppColor.teal`, `#0E6971`). Colors live in `lib/core/theme/app_color.dart`; title styles are set in `getLightTheme()`.

Folder layout follows the [playground architecture](../README.md#app-architecture-and-folder-structure): `core/`, `features/`, `l10n/`, and **`shared_widgets/`** for UI used by more than one screen. Counter lessons live under **`features/providers/`**. Scenario shells live under **`features/scenarios/`**. **`ErrorWidget`** and **`FullWidthElevatedButton`** live in `shared_widgets/`. **`ErrorWidget`** is `assets/img/error_dragon.png` plus the localized “an error occurred” line. Files that import it also `hide ErrorWidget` on `package:flutter/material.dart`, because Flutter already uses that name for the build-failure fallback. **`FullWidthElevatedButton`** is a labeled, full-width `ElevatedButton`. The UI locale is pinned to English (`locale: Locale('en')` in `MaterialApp`); German ARBs remain for tests and later switching. `l10n.yaml` lists `en` first as the fallback.

[![iOS](../assets/badges/ios.svg)](https://developer.apple.com/ios/)

There is no Android project or Chrome. Run on the iOS Simulator.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## [Riverpod](https://pub.dev/packages/flutter_riverpod)

### What is Riverpod

Riverpod is a **state management and dependency injection** framework for Flutter.

A provider is a declared source of data. Widgets subscribe to it. When the data changes, only the widgets that watch it rebuild.

That is the whole idea: state lives outside the widget tree, and the UI reacts to it.

<p align="right"><a href="#readme-top">back to top</a></p>

### Why Riverpod

`setState` is fine for local UI, but it does not scale once several screens need the same value.

The older `provider` package works, but it depends on `BuildContext`. That leads to easy mistakes: reading a provider from the wrong place in the tree, or failing tests because the widget tree is missing an ancestor.

Riverpod avoids that:

- Providers are **global declarations**, not inherited widgets. You do not need `context` to create or read them.
- **Compile-safe**: a missing provider is a type error, not a runtime crash.
- **Testable**: you can override providers in tests without wrapping the whole tree in the right ancestors.
- **Explicit rebuilds**: `ref.watch` rebuilds, `ref.read` does not. You choose.

Use Riverpod when state is shared, async, or needs to be tested. Keep `setState` for tiny local UI that never leaves one widget.

<p align="right"><a href="#readme-top">back to top</a></p>

### watch, read, listen

These three are how a widget talks to a provider. Match the call to the job.

**`ref.watch(provider)`** subscribes. When the value changes, this widget rebuilds. Use it in `build` to **show** the value (`final count = ref.watch(counterStateProvider)`).

**Do not `watch` in a button callback.** A tap is not a rebuild. The subscribe would be wasted, and it is easy to think the UI will update from that line. It will not.

**`ref.read(provider)`** is a one-shot lookup. No subscribe, no rebuild. Use it in `onPressed` and in tests (`container.read` is the same idea): `ref.read(counterStateProvider.notifier).state++`.

**Do not `read` in `build` for a value you display.** The widget will not rebuild when the provider changes, so the text stays stale.

**`ref.listen(provider, (previous, next) { ... })`** runs a callback when the value changes. Use it for **side effects**: snackbar, dialog, navigation. Not for putting the number on screen — that is `watch`.

`.notifier` is the object that owns the mutable value. `watch` / `read` the provider for the `int`. `read` the `.notifier` when you need to change it.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Providers

A provider is the declared source of state. The type you pick is how that state is allowed to change. The same counter in this app shows the steps: local `setState`, a `Notifier` class, an `AsyncNotifier` when the first value is a `Future` (kept alive or auto-disposed), and `StateProvider` as the shortcut.

<p align="right"><a href="#readme-top">back to top</a></p>

### No provider

No provider means the count lives in the widget with `setState`. Nothing outside that screen can read it.

**Use it when** only one widget cares: an expansion tile, a password-field visibility toggle, a one-off animation flag.

**Do not use it when** a second screen needs the same count, you want to test the increment without pumping the widget, or the value must survive leaving the page. That is when you lift it into a provider.

<p align="right"><a href="#readme-top">back to top</a></p>

### NotifierProvider

`NotifierProvider` is the default way to hold **mutable state outside the widget**. Updates go through a **class with methods**. The widget calls `increment()` or `applyFilter()`. The notifier owns the rules.

This is the type everything else is built on. A `StateProvider` is a notifier whose public API is only `state`.

**Use it when** the value leaves the widget: plus and minus must not go below zero, a form field needs validation, a list can add and remove items, or two screens share the same actions. Use it as soon as you would write a test for the change.

**Do not use it when** the value never changes (that is a read-only `Provider`) or the widget is the only thing that ever sees a one-off toggle. Do not reach for a notifier to store a theme color constant. Do not use it when the first value is a `Future` — that is `AsyncNotifierProvider`.

<p align="right"><a href="#readme-top">back to top</a></p>

### AsyncNotifier Persistent State

`AsyncNotifierProvider` is the same class-and-methods idea, but `build` returns a `Future`. Riverpod stores **`AsyncValue<T>`**: loading, error, data.

This screen uses a **plain** `AsyncNotifierProvider` (`isAutoDispose: false`). The count lives **in memory** on that notifier, not on disk. The notifier lives as long as `ProviderScope` (the app). Leave with the back button, open the screen again: **same count, no loading**.

`ref.watch` is therefore not an `int`. It is `AsyncValue<int>`. **`when`** maps each state to UI: `loading` (spinner), `error` (`ErrorWidget`), `data` (the counter). Skip a callback and that state has no widget. `switch` on `AsyncValue` does the same job.

Do not read `.value` or `.value!` in `build` to “just show the number”. While `build()` is still awaiting, there is no number yet. Buttons still `ref.read(...notifier)` like the sync screen. `when` is only for rendering.

**`build`, `state`, and `future` are one object.** The provider holds a single `PersistentStateAsyncNotifier`. First `watch`/`read`: Riverpod constructs it and calls `build()`. While `build()` awaits, `state` is `AsyncLoading`. `build()` `return`s `0` → `state = AsyncData(0)`. That return value **is** the first `state`.

`future` is not the `Future.delayed` in `build()`. It is a getter on `AsyncNotifier`: unwrap `state` as `int` once it is no longer loading. After `build()` finished, `await future` is `0`. The `<int>` on `AsyncNotifier<int>` is why that value is an `int`. Plus calls `.increment()` on **that same instance**; `await future` reads the current `state`, then `state = AsyncData(current + 1)` replaces it. `build()` does not run again.

**`AsyncValue.guard`** is the clean way to turn a `Future` into `AsyncValue` without writing try/catch. `state = await AsyncValue.guard(fakeApi)` → success becomes `AsyncData`, `throw` / `Future.error` becomes `AsyncError`. `guard` does **not** set loading. Both async screens still assign `state = const AsyncLoading()` first so the spinner shows now. `reset()` uses this path. The commented `throw` inside `reset()` is how you would fake a failed reload instead of returning `0`.

The **`error`** branch is not empty theory. The screen counts **page enters** once in `initState` (not in `build()`, or every rebuild would increment) and calls `onPageEntered()`. `build()` on the notifier does not run again (no `autoDispose`), so the visit count lives on that notifier. Every 3rd enter (`visit % 3 == 0`) sets `AsyncLoading`, then `guard` throws `FakePageEnterException` → `AsyncError`. Visit 4 restores the **persisted** count. Same notifier; the error was only a state. The UI is **`ErrorWidget`** (`lib/shared_widgets/error_widget.dart`): `assets/img/error_dragon.png` and `l10n.errorOccurred`. Imports `hide ErrorWidget` because Flutter already uses that name for the build-failure fallback.

`when` defaults **`skipLoadingOnRefresh: true`**. After `invalidate` the widget would keep painting the old number until the Future finishes. Both async screens set `skipLoadingOnRefresh` / `skipLoadingOnReload` to **false** so `loading:` runs on reset.

**Use it when** the first value comes from a repository, HTTP, or disk, and the result should survive leaving the screen (a profile you still need on the next page).

**Do not use it when** the number is already in memory and there is no `Future`. That is `NotifierProvider`. Do not wrap a local counter in `AsyncValue` just to look async.

<p align="right"><a href="#readme-top">back to top</a></p>

### AsyncNotifier Non-Persistent State

Same `AsyncNotifier` class, same `when`, same plus / minus / **reset** FAB, same `build` → `state` → `future` chain (see Persistent State). The `error` branch uses the same **`ErrorWidget`**. The only code difference is **`AsyncNotifierProvider.autoDispose`**. There is no SharedPreferences, no `keepAlive`, no extra cache. “Non-persistent” here means **lifetime**: the count lives in memory only while something `watch`es it.

How that lifetime works:

1. The screen `ref.watch`es the provider. That listener keeps the notifier alive.
2. Plus / minus write `state` on that same in-memory notifier.
3. **Back** pops the screen. The widget is gone, last watcher is gone, Riverpod **disposes** the notifier. Count `5` does not exist anymore.
4. Open the screen again: a **new** notifier, `build()` runs, spinner, count is **0**.

**Reset** is a different path. The refresh FAB stays on the page, assigns `AsyncLoading`, then `AsyncValue.guard` (same as Persistent State). It does not dispose the provider. The two screens only differ on **leave**.

**Use it when** the async state belongs to that screen only: a form fetch, a one-off detail page, a retryable request you do not want to keep in memory after pop.

**Do not use it when** another route still needs the same `AsyncValue` after you leave. That is Persistent State (no `autoDispose`).

<p align="right"><a href="#readme-top">back to top</a></p>

### StateProvider

`StateProvider` is **not** a second kind of state. It is a pre-built notifier that holds **one mutable value**. The UI writes `state` directly. There are no named methods and no place for rules.

In Riverpod 3 `StateProvider` is **legacy** (`legacy.dart`). Do not start a feature with it. Fine to recognize in older code or to lift a throwaway `int`. New mutable state goes through `NotifierProvider`.

**Use it when** the value is a primitive or enum, any write is valid, and nothing else depends on how it changed. Typical cases: a selected tab, a filter chip, a “dark mode” switch, a counter you will throw away.

**Do not use it when** two writes must stay consistent, a value has a floor or a max, more than one field changes together, or you would want to unit-test the update. Do not use it for login, a cart, or anything that talks to an API. Use `NotifierProvider`.

<p align="right"><a href="#readme-top">back to top</a></p>

### How they connect

Conceptually there is one ladder:

1. **No provider** — `setState` on one screen. Fine while nobody else needs the count.
2. **NotifierProvider** — same number, now a class outside the widget. Writes go through methods.
3. **AsyncNotifier Persistent State** — `build` is a `Future`. In memory for the app, not disk. Leave the page; the count stays.
4. **AsyncNotifier Non-Persistent State** — same class, only `.autoDispose`. Leave the page; last watcher gone, notifier disposed, next visit loads from scratch.
5. **StateProvider** — the same notifier with the class stripped off. Writes are `state++`. Legacy in Riverpod 3.

The app screens still go `setState` → `StateProvider` → `NotifierProvider` → Persistent AsyncNotifier → Non-Persistent AsyncNotifier. That is the smallest syntax jump from a widget field, then you write the class, then the class may wait, then you choose whether that wait survives a pop. Read the types the other way around: the class is the foundation, async is the class plus `AsyncValue`, `autoDispose` is lifetime, the shortcut is optional.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Getting Started

Clone the playground, then open this project folder:

```
https://github.com/foxnoir/noirs_flutter_playground.git
```

```
git@github.com:foxnoir/noirs_flutter_playground.git
```

```
cd riverpod_basics
fvm install
fvm flutter pub get
fvm flutter run
```

`fvm flutter run` uses the **iOS Simulator**. There is no Android project or Chrome.

This project is pinned with [FVM](https://fvm.app). After `fvm install`, Cursor uses the SDK at `.fvm/flutter_sdk`.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Testing

A test is a small program that checks your code. It does not change the app. You run an action, then **assert** that the result is what you meant.

`expect(actual, matcher)` is that assertion: left is what happened, right is what must be true. If they differ, the test fails. That is the point — you catch the break before a user does.

Keep tests deterministic. One test, one claim. Do not depend on the order of other tests.

<p align="right"><a href="#readme-top">back to top</a></p>

### Testing in Flutter

`flutter_test` is the same idea on a fake widget tree. You do not need a simulator for these.

- **`test`** — no widgets. Use it for logic and providers.
- **`testWidgets`** — a screen via `WidgetTester`.
- **`pumpWidget`** — put a widget on that screen.
- **`find.text` / `find.byIcon`** — locate widgets.
- **`tester.tap`** — a user gesture.
- **`pump`** — one frame. Use it after `setState` or a provider notify.
- **`pumpAndSettle`** — wait until animations and `go_router` finish.
- **`addTearDown`** — cleanup after **this** test, pass or fail. Do not put `dispose()` only at the bottom of the happy path: a failing `expect` would skip it.

`test/` mirrors `lib/`. Each source file has a matching `*_test.dart` in the same folders (`features/providers/`, `presentation/`, `core/router/`, `shared_widgets/`).

Examples:

- `lib/main.dart` → `test/main_test.dart`
- `lib/features/landing_page/presentation/landing_page.dart` → `test/features/landing_page/presentation/landing_page_test.dart`
- `lib/features/landing_page/presentation/widgets/landing_page_dropdown.dart` → `test/features/landing_page/presentation/widgets/landing_page_dropdown_test.dart`
- `lib/features/providers/state_provider/presentation/providers/state_provider.dart` → `test/features/providers/state_provider/presentation/providers/state_provider_test.dart`

<p align="right"><a href="#readme-top">back to top</a></p>

### Testing Riverpod

**Dependency injection** means a unit does not construct its own dependencies (API, database, clock). They are passed in. In a test you pass a fake, so nothing hits the network. That is why DI is so useful for tests.

Riverpod **is** that injection. `ProviderScope` and `ProviderContainer` hold the graph. `overrideWith` replaces one node. You do not add GetIt for feature state. GetIt is also DI; a second locator is only worth it in a mixed codebase that already uses it. This playground stays on Riverpod.

Two test shapes:

1. **Provider tests** — no widgets. Create a `ProviderContainer`, `read` the provider, mutate through `.notifier`, then dispose. See `test/features/providers/state_provider/presentation/providers/state_provider_test.dart`, `test/features/providers/async_notifier_persistent_state/presentation/providers/`, and `test/features/providers/async_notifier_non_persistent_state/presentation/providers/` (the last one closes the listener and checks the provider is gone).
2. **Widget tests** — wrap the tree in `ProviderScope` (the app already does this in `main.dart`). Tap UI, assert text. Fake repositories later with `overrides`.

`addTearDown(container.dispose)` drops listeners and cached state so the next test starts clean.

The Riverpod calls in tests are the same as in the app. See [watch, read, listen](#watch-read-listen). In a `ProviderContainer` you write `container.read` instead of `ref.read`.

- **`ProviderScope`** — widget that creates the container for the real app and for widget tests.
- **`ProviderContainer`** — the same world without widgets. Use it in provider tests.
- **`overrideWith`** — replace a provider in this scope/container so tests never hit a real API.

### Test coverage

<!-- coverage-percent:start -->
**95.2%** line coverage (380 of 399 lines).
<!-- coverage-percent:end -->

![Coverage](assets/coverage/card.svg)

The card and the header badge are regenerated by the playground [coverage pipeline](../README.md#coverage-pipeline) when you run `./coverage_pipeline/update_all.sh`. They are **not** updated on commit. On **push**, tests must pass (`pre-push`); GitHub Actions also runs tests on Linux and does **not** commit the SVGs. `fvm flutter test --coverage` only writes local `lcov.info` for **Coverage Gutters**, and only for files the tests loaded. Unused `lib/` files are added as 0 hits when the playground generator runs. Saving a Dart file does not update the SVGs by itself.

```
cd riverpod_basics
fvm flutter test --coverage
```

Or run the VS Code task **Flutter: Test with coverage**, then Command Palette → **Coverage Gutters: Display Coverage**.

How the badges are produced: playground [coverage pipeline](../README.md#coverage-pipeline).

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Changelog

Changes to this playground: [noirs_flutter_playground](https://github.com/foxnoir/noirs_flutter_playground).

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Sources

- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
- [Flutter Riverpod For Complete Beginner](https://www.udemy.com/course/flutter-riverpod-for-complete-beginner/) — [Richard Dewan](https://github.com/rddewan)

<p align="right"><a href="#readme-top">back to top</a></p>

