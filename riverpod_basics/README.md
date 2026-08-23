<a name="readme-top"></a>

<!-- Top Links Bar -->

[![LinkedIn][linkedin-shield]][linkedin-url]
[![X][x-shield]][x-url]
[![Instagram][instagram-shield]][instagram-url]

<!-- PROJECT LOGO -->
<br />

<div align="center">
  <img src="assets/logo.png" alt="Logo" width="80" height="80">
  <h1 align="center">Riverpod Basics</h1>

  <p align="left">
     Practice project for Riverpod fundamentals: providers, ConsumerWidget, and reactive Flutter UI.
  </p>
  
  <p align="left">
    <a href="lib/"><strong>Explore the project »</strong></a>
    <br/>
    <a href="../README.md"><strong>Back to playground »</strong></a>
  </p>
</div>

[![Flutter][flutter]][flutter-url]
[![Dart][dart]][dart-url]
[![Riverpod][riverpod]][riverpod-url]
[![GoRouter][gorouter]][gorouter-url]
[![Flutter Localizations][flutter-localizations]][flutter-localizations-url]
[![Intl][intl]][intl-url]
[![Very Good Analysis][very-good]][very-good-url]
[![FVM][fvm]][fvm-url]
[![iOS][ios]][ios-url]
[![Web][web]][web-url]

[![Coverage][coverage-shield]](#test-coverage)

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-this-project">About this project</a></li>
    <li>
      <a href="#riverpod">Riverpod</a>
      <ul>
        <li><a href="#what-is-riverpod">What is Riverpod</a></li>
        <li><a href="#why-riverpod">Why Riverpod</a></li>
        <li><a href="#what-does-a-provider-do">What Does a Provider Do</a></li>
        <li><a href="#core-riverpod-providers">Core Riverpod Providers</a></li>
        <li><a href="#summary">Summary</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#test-coverage">Test coverage</a></li>
        <li><a href="#coverage-pipeline">Coverage pipeline</a></li>
      </ul>
    </li>
    <li><a href="#changelog">Changelog</a></li>
    <li><a href="#sources">Sources</a></li>
  </ol>
</details>

---

## About this project

This app is the **Riverpod** practice project in [Noir's Flutter Playground](../README.md).

The goal is to learn the building blocks: what a provider is, why Riverpod exists, which provider type to pick, and how widgets read that state.

[![iOS][ios]][ios-url]
[![Web][web]][web-url]

There is no Android project. Run on the iOS Simulator or Chrome.

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

### What Does a Provider Do

A **Provider** in Riverpod has three jobs:

1. **Creates** a resource or state (a value, a class, or async work).
2. **Stores** it for the app lifetime, so it survives widget rebuilds.
3. **Notifies** widgets when it changes, so the UI stays in sync.

A provider is the **source of data**. State is the **current value** of that source.

- `Provider` returns a value (read-only).
- `StateProvider` stores a value that can change.

<p align="right"><a href="#readme-top">back to top</a></p>

### Core Riverpod Providers

Riverpod has different providers for different kinds of state.

#### 1. `Provider` — read-only value

Use it for constants, config, or computed values that do not change on their own.

```dart
final helloProvider = Provider((ref) => "Hello, Riverpod!");
```

<p align="right"><a href="#readme-top">back to top</a></p>

#### 2. `StateProvider` — simple mutable state

Use it for a single value that the UI can update: a counter, a flag, a selected tab.

```dart
final counterProvider = StateProvider<int>((ref) => 0);

class CounterScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Counter: $counter"),
            ElevatedButton(
              onPressed: () => ref.read(counterProvider.notifier).state++,
              child: Text("Increase"),
            ),
          ],
        ),
      ),
    );
  }
}
```

- `ref.watch(counterProvider)` rebuilds the widget when the value changes.
- `ref.read(counterProvider.notifier).state++` updates the value from a callback.

<p align="right"><a href="#readme-top">back to top</a></p>

#### 3. `FutureProvider` — one-shot async data

Use it for API calls, database reads, or anything that completes once.

```dart
final userNameProvider = FutureProvider<String>((ref) async {
  await Future.delayed(Duration(seconds: 2));
  return "John Doe";
});

class UserScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userNameProvider);
    return Scaffold(
      body: Center(
        child: userAsync.when(
          data: (name) => Text("Hello, $name!"),
          loading: () => CircularProgressIndicator(),
          error: (err, stack) => Text("Error: $err"),
        ),
      ),
    );
  }
}
```

`when(data, loading, error)` forces you to handle all three states.

<p align="right"><a href="#readme-top">back to top</a></p>

#### 4. `StreamProvider` — continuous data

Use it for live values: WebSockets, Firestore, sensors, a ticking clock.

```dart
final timeProvider = StreamProvider<DateTime>((ref) async* {
  while (true) {
    await Future.delayed(Duration(seconds: 1));
    yield DateTime.now();
  }
});

class ClockScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timeProvider);
    return Scaffold(
      body: Center(
        child: time.when(
          data: (time) => Text("Time: ${time.toIso8601String()}"),
          loading: () => CircularProgressIndicator(),
          error: (err, stack) => Text("Error: $err"),
        ),
      ),
    );
  }
}
```

The widget rebuilds every time the stream emits.

<p align="right"><a href="#readme-top">back to top</a></p>

#### 5. `StateNotifierProvider` — state with methods

Use it when the state needs more than one field, or when updates should go through named methods instead of `state++`.

```dart
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  void increment() => state++;
  void decrement() => state--;
}

final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) => CounterNotifier(),
);

class CounterScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterNotifierProvider);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Counter: $counter"),
            ElevatedButton(
              onPressed: () => ref.read(counterNotifierProvider.notifier).increment(),
              child: Text("Increase"),
            ),
            ElevatedButton(
              onPressed: () => ref.read(counterNotifierProvider.notifier).decrement(),
              child: Text("Decrease"),
            ),
          ],
        ),
      ),
    );
  }
}
```

Logic lives in the notifier. The widget only watches and calls methods.

<p align="right"><a href="#readme-top">back to top</a></p>

### Summary

| Provider | Description | Best use case |
| --- | --- | --- |
| `Provider` | Read-only value | Config, constants |
| `StateProvider` | Simple mutable state | Counters, flags, form fields |
| `FutureProvider` | One-time async work | API requests, database reads |
| `StreamProvider` | Continuous data | Firestore, WebSockets |
| `StateNotifierProvider` | State with methods | Auth, cart, anything with real logic |

Widgets that read providers use `ConsumerWidget` and `WidgetRef`:

- `ref.watch` in `build` — rebuild when the value changes
- `ref.read` in callbacks — run an action without rebuilding

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

`fvm flutter run` uses the **iOS Simulator**. For web, use `fvm flutter run -d chrome`. There is no Android project.

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

### Coverage pipeline

The badge on GitHub must match the code in that commit.

1. Tests run with coverage (`fvm flutter test --coverage`).
2. `lcov.info` is turned into two images: [`assets/coverage/badge.svg`](assets/coverage/badge.svg) (header) and [`assets/coverage/card.svg`](assets/coverage/card.svg) (README card), plus the percent in this file.
3. `pre-commit` stages those files so they ride in the **same** commit.
4. `pre-push` runs the tests again and blocks a failing push.
5. GitHub Actions repeats the generation and fails if the committed images are stale.

This app owns that flow in [`coverage_pipeline/`](coverage_pipeline/).

- [`install-git-hooks.sh`](coverage_pipeline/install-git-hooks.sh) — link `pre-commit` and `pre-push` when this folder is its own git repo
- [`update_coverage.sh`](coverage_pipeline/update_coverage.sh) — tests + image generation for **this** app
- [`coverage_badge.py`](coverage_pipeline/coverage_badge.py) — SVG badge and card from `lcov.info`
- [`git-hooks/pre-commit`](coverage_pipeline/git-hooks/pre-commit) / [`pre-push`](coverage_pipeline/git-hooks/pre-push)
- [`.github/workflows/coverage.yml`](.github/workflows/coverage.yml) — CI check

```
./coverage_pipeline/update_coverage.sh
```

Inside this playground the install script does not attach hooks to the playground repo. After you copy this folder into its **own** git repo:

```
./coverage_pipeline/install-git-hooks.sh
```

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Changelog

Changes to this playground: [noirs_flutter_playground](https://github.com/foxnoir/noirs_flutter_playground).

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Sources

- [Riverpod](https://fnfidanci.medium.com/the-right-way-to-use-riverpod-in-flutter-77869f9b741c)
- [Login Layout Inspo](https://github.com/gerfagerfa/login_and_signup)
- [Images](https://www.marigonasuli.com/)

<p align="right"><a href="#readme-top">back to top</a></p>

---

[coverage-shield]: assets/coverage/badge.svg
[dart]: https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white
[dart-url]: https://dart.dev/
[flutter]: https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white
[flutter-url]: https://flutter.dev/
[flutter-localizations]: https://img.shields.io/badge/Flutter%20Localizations-0170F3.svg?style=for-the-badge&logo=flutter&logoColor=white
[flutter-localizations-url]: https://docs.flutter.dev/ui/internationalization
[fvm]: https://img.shields.io/badge/FVM-0175C2.svg?style=for-the-badge&logo=flutter&logoColor=white
[fvm-url]: https://fvm.app
[gorouter]: https://img.shields.io/badge/GoRouter-0082FC.svg?style=for-the-badge&logo=flutter&logoColor=white
[gorouter-url]: https://pub.dev/packages/go_router
[instagram-shield]: https://img.shields.io/badge/Instagram-%23E4405F.svg?style=for-the-badge&logo=instagram&logoColor=white
[instagram-url]: https://www.instagram.com/codeincouture/
[intl]: https://img.shields.io/badge/Intl-FFA500.svg?style=for-the-badge&logo=dart&logoColor=white
[intl-url]: https://pub.dev/packages/intl
[ios]: https://img.shields.io/badge/iOS-000000.svg?style=for-the-badge&logo=apple&logoColor=white
[ios-url]: https://developer.apple.com/ios/
[linkedin-shield]: https://img.shields.io/badge/LinkedIn-%230A66C2.svg?style=for-the-badge&logo=linkedin&logoColor=white
[linkedin-url]: https://www.linkedin.com/in/tanja-polz-5636401a5/
[riverpod]: https://img.shields.io/badge/Riverpod-0468D7.svg?style=for-the-badge&logo=riverpod&logoColor=white
[riverpod-url]: https://pub.dev/packages/flutter_riverpod
[very-good]: https://img.shields.io/badge/Very%20Good%20Analysis-B22C89.svg?style=for-the-badge&logo=flutter&logoColor=white
[very-good-url]: https://pub.dev/packages/very_good_analysis
[web]: https://img.shields.io/badge/Web-02569B.svg?style=for-the-badge&logo=googlechrome&logoColor=white
[web-url]: https://docs.flutter.dev/platform-integration/web
[x-shield]: https://img.shields.io/badge/-%23000000.svg?style=for-the-badge&logo=x&logoColor=white
[x-url]: https://twitter.com/_foxnoir_?lang=de
