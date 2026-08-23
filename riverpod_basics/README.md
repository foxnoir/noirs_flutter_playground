<a name="readme-top"></a>

<!-- Top Links Bar -->

<a href="#test-coverage"><img align="right" src="assets/coverage/badge.svg" alt="Coverage"></a>

[![LinkedIn][linkedin-shield]][linkedin-url]
[![X][x-shield]][x-url]
[![Instagram][instagram-shield]][instagram-url]

<!-- PROJECT LOGO -->
<br />

<div align="center">
  <img src="../assets/logo.png" alt="Logo" width="179" height="179">
  <h1 align="center">Riverpod Basics</h1>
  <p>
     Practice project for Riverpod: no provider, StateProvider, NotifierProvider, and when to pick which.
  </p>
</div>

---

<div align="left">

[![Flutter][flutter]][flutter-url]
[![Dart][dart]][dart-url]
[![Riverpod][riverpod]][riverpod-url]
[![GoRouter][gorouter]][gorouter-url]
[![Flutter Localizations][flutter-localizations]][flutter-localizations-url]
[![Intl][intl]][intl-url]
[![Very Good Analysis][very-good]][very-good-url]
[![FVM][fvm]][fvm-url]
[![iOS][ios]][ios-url]

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
        <li><a href="#no-provider">No provider</a></li>
        <li><a href="#stateprovider">StateProvider</a></li>
        <li><a href="#notifierprovider">NotifierProvider</a></li>
        <li><a href="#how-they-connect">How they connect</a></li>
        <li><a href="#summary">Summary</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
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

The first lesson is the same button-press counter three ways: local `setState` (no provider), then `StateProvider`, then `NotifierProvider`. The point is when to leave the widget and when to move again.

[![iOS][ios]][ios-url]

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

### No provider

No provider means the count lives in the widget with `setState`. Nothing outside that screen can read it.

**Use it when** only one widget cares: an expansion tile, a password-field visibility toggle, a one-off animation flag.

**Do not use it when** a second screen needs the same count, you want to test the increment without pumping the widget, or the value must survive leaving the page. That is when you lift it into a provider.

<p align="right"><a href="#readme-top">back to top</a></p>

### StateProvider

`StateProvider` holds **one mutable value**. The UI writes `state` directly. There are no named methods and no place for rules.

**Use it when** the value is a primitive or enum, any write is valid, and nothing else depends on how it changed. Typical cases: a selected tab, a filter chip, a “dark mode” switch, a throwaway counter on one screen.

**Do not use it when** two writes must stay consistent, a value has a floor or a max, more than one field changes together, or you would want to unit-test the update. Do not use it for login, a cart, or anything that talks to an API.

<p align="right"><a href="#readme-top">back to top</a></p>

### NotifierProvider

`NotifierProvider` holds the same kind of state, but updates go through a **class with methods**. The widget calls `increment()` or `applyFilter()`. The notifier owns the rules.

**Use it when** plus and minus must not go below zero, a form field needs validation, a list can add and remove items, or two screens share the same actions. Use it as soon as you would write a test for the change.

**Do not use it when** the value never changes (that is a read-only `Provider`) or the widget is the only thing that ever sees a one-off toggle. Do not reach for a notifier to store a theme color constant.

<p align="right"><a href="#readme-top">back to top</a></p>

### How they connect

The app walks the same counter up the ladder.

1. **No provider** — `setState` on one screen. Fine while nobody else needs the count.
2. **StateProvider** — same number, now outside the widget. Any screen can watch it. Writes are still `state++`.
3. **NotifierProvider** — same number, but updates go through methods. Use this when minus has a floor or the change should be tested.

`StateProvider` is a shortcut: a tiny notifier whose public API is “set `state`”. You graduate when the widget starts making decisions.

<p align="right"><a href="#readme-top">back to top</a></p>

### Summary

Start with `setState` while the value is local. Move to `StateProvider` when another widget must see it. Move to `NotifierProvider` when updates need names and rules.

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

---

[dart]: ../assets/badges/dart.svg
[dart-url]: https://dart.dev/
[flutter]: ../assets/badges/flutter.svg
[flutter-url]: https://flutter.dev/
[flutter-localizations]: ../assets/badges/flutter_localizations.svg
[flutter-localizations-url]: https://docs.flutter.dev/ui/internationalization
[fvm]: ../assets/badges/fvm.svg
[fvm-url]: https://fvm.app
[gorouter]: ../assets/badges/gorouter.svg
[gorouter-url]: https://pub.dev/packages/go_router
[instagram-shield]: ../assets/badges/instagram.svg
[instagram-url]: https://www.instagram.com/codeincouture/
[intl]: ../assets/badges/intl.svg
[intl-url]: https://pub.dev/packages/intl
[ios]: ../assets/badges/ios.svg
[ios-url]: https://developer.apple.com/ios/
[linkedin-shield]: ../assets/badges/linkedin.svg
[linkedin-url]: https://www.linkedin.com/in/tanja-polz-5636401a5/
[riverpod]: ../assets/badges/riverpod.svg
[riverpod-url]: https://pub.dev/packages/flutter_riverpod
[very-good]: ../assets/badges/very_good.svg
[very-good-url]: https://pub.dev/packages/very_good_analysis
[web]: ../assets/badges/web.svg
[web-url]: https://docs.flutter.dev/platform-integration/web
[x-shield]: ../assets/badges/x.svg
[x-url]: https://twitter.com/_foxnoir_?lang=de
