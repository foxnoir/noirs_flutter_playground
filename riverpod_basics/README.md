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
     Practice project for Riverpod: no provider, NotifierProvider, and StateProvider as the shortcut.
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

The first lesson is the same button-press counter three ways. `NotifierProvider` is the real mutable type. `StateProvider` is a tiny notifier whose only API is “set `state`”. Local `setState` stays in the widget. The point is when to leave the widget, and that the shortcut is not a different kind of state.

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

A provider is the declared source of state. The type you pick is how that state is allowed to change. The same counter in this app shows the three steps: local `setState`, a `Notifier` class, and `StateProvider` as the shortcut.

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

**Do not use it when** the value never changes (that is a read-only `Provider`) or the widget is the only thing that ever sees a one-off toggle. Do not reach for a notifier to store a theme color constant.

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
2. **NotifierProvider** — same number, now a class outside the widget. Any screen can watch it. Writes go through methods.
3. **StateProvider** — the same notifier with the class stripped off. Writes are `state++`. You already know what it is.

The app screens still go `setState` → `StateProvider` → `NotifierProvider`. That is the smallest syntax jump from a widget field, then you write the class. Read the types the other way around: the class is the foundation, the shortcut is optional.

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

See `test/widget_test.dart`.

<p align="right"><a href="#readme-top">back to top</a></p>

### Testing Riverpod

**Dependency injection** means a unit does not construct its own dependencies (API, database, clock). They are passed in. In a test you pass a fake, so nothing hits the network. That is why DI is so useful for tests.

Riverpod **is** that injection. `ProviderScope` and `ProviderContainer` hold the graph. `overrideWith` replaces one node. You do not add GetIt for feature state. GetIt is also DI; a second locator is only worth it in a mixed codebase that already uses it. This playground stays on Riverpod.

Two test shapes:

1. **Provider tests** — no widgets. Create a `ProviderContainer`, `read` the provider, mutate through `.notifier`, then dispose. See `test/features/state_provider/counter_state_provider_test.dart`.
2. **Widget tests** — wrap the tree in `ProviderScope` (the app already does this in `main.dart`). Tap UI, assert text. Fake repositories later with `overrides`.

`addTearDown(container.dispose)` drops listeners and cached state so the next test starts clean.

The Riverpod calls in tests are the same as in the app. See [watch, read, listen](#watch-read-listen). In a `ProviderContainer` you write `container.read` instead of `ref.read`.

- **`ProviderScope`** — widget that creates the container for the real app and for widget tests.
- **`ProviderContainer`** — the same world without widgets. Use it in provider tests.
- **`overrideWith`** — replace a provider in this scope/container so tests never hit a real API.

### Test coverage

<!-- coverage-percent:start -->
**66.3%** line coverage (65 of 98 lines).
<!-- coverage-percent:end -->

![Coverage](assets/coverage/card.svg)

The card and the header badge are regenerated on every commit and committed with the same snapshot as the code. Raw `lcov.info` stays local for **Coverage Gutters**.

```
cd riverpod_basics
fvm flutter test --coverage
```

Or run the VS Code task **Flutter: Test with coverage**, then Command Palette → **Coverage Gutters: Display Coverage**.

The shared scripts live in the playground [coverage pipeline](../README.md#coverage-pipeline).

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Changelog

Changes to this playground: [noirs_flutter_playground](https://github.com/foxnoir/noirs_flutter_playground).

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Sources

- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)

<p align="right"><a href="#readme-top">back to top</a></p>

