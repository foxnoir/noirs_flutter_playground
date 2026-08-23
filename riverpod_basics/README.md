<a name="readme-top"></a>

<!-- Top Links Bar -->

[![LinkedIn][linkedin-shield]][linkedin-url]
[![X][x-shield]][x-url]
[![Instagram][instagram-shield]][instagram-url]

<!-- PROJECT LOGO -->
<br />

<div align="center">
  <img src="images/logo.png" alt="Logo" width="80" height="80">
  <h1 align="center">Riverpod Basics</h1>

  <p align="left">
     Practice project for Riverpod fundamentals: providers, ConsumerWidget, and reactive Flutter UI.
  </p>
  
  <p align="left">
    <a href="lib/"><strong>Explore the project »</strong></a>
    ·
    <a href="../README.md"><strong>Back to playground »</strong></a>
    <br/>
  </p>
</div>

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
      <a href="#tech-stack">Tech Stack</a>
      <ul>
        <li><a href="#build-with">Build With</a></li>
      </ul>
    </li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#changelog">Changelog</a></li>
    <li><a href="#sources">Sources</a></li>
  </ol>
</details>

---

## About this project

This app is the **Riverpod** practice project in [Noir's Flutter Playground](../README.md).

The goal is to learn the building blocks: what a provider is, why Riverpod exists, which provider type to pick, and how widgets read that state.

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

## Tech Stack

### Build With

- [![Flutter][flutter]][flutter-url]
- [![Dart][dart]][dart-url]
- [![Riverpod][riverpod]][riverpod-url]

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
flutter pub get
flutter run
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

[dart]: https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white
[dart-url]: https://dart.dev/
[flutter]: https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white
[flutter-url]: https://flutter.dev/
[instagram-shield]: https://img.shields.io/badge/Instagram-%23E4405F.svg?style=for-the-badge&logo=instagram&logoColor=white
[instagram-url]: https://www.instagram.com/codeincouture/
[linkedin-shield]: https://img.shields.io/badge/LinkedIn-%230A66C2.svg?style=for-the-badge&logo=linkedin&logoColor=white
[linkedin-url]: https://www.linkedin.com/in/tanja-polz-5636401a5/
[riverpod]: https://img.shields.io/badge/Riverpod-0468D7.svg?style=for-the-badge&logo=riverpod&logoColor=white
[riverpod-url]: https://pub.dev/packages/flutter_riverpod
[x-shield]: https://img.shields.io/badge/-%23000000.svg?style=for-the-badge&logo=x&logoColor=white
[x-url]: https://twitter.com/_foxnoir_?lang=de
