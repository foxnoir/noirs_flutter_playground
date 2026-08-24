<a name="readme-top"></a>

<!-- Top Links Bar -->

[![LinkedIn](assets/badges/linkedin.svg)](https://www.linkedin.com/in/tanja-polz-5636401a5/)
[![X](assets/badges/x.svg)](https://twitter.com/_foxnoir_?lang=de)
[![Instagram](assets/badges/instagram.svg)](https://www.instagram.com/codeincouture/)

<!-- PROJECT LOGO -->
<br />

<div align="center">
  <img src="assets/logo.png" alt="Logo" width="179" height="179">
  <h1 align="center">Noir's Flutter Playground</h1>
  <p>
     Practice projects for Flutter — among other things Riverpod, architecture, and advanced topics.
  </p>
</div>

---

<div align="left">

[![Flutter](assets/badges/flutter.svg)](https://flutter.dev/)
[![Dart](assets/badges/dart.svg)](https://dart.dev/)
[![Riverpod](assets/badges/riverpod.svg)](https://pub.dev/packages/flutter_riverpod)
[![GoRouter](assets/badges/gorouter.svg)](https://pub.dev/packages/go_router)
[![Flutter Localizations](assets/badges/flutter_localizations.svg)](https://docs.flutter.dev/ui/internationalization)
[![Intl](assets/badges/intl.svg)](https://pub.dev/packages/intl)
[![Very Good Analysis](assets/badges/very_good.svg)](https://pub.dev/packages/very_good_analysis)
[![FVM](assets/badges/fvm.svg)](https://fvm.app)
[![iOS](assets/badges/ios.svg)](https://developer.apple.com/ios/)
[![Web](assets/badges/web.svg)](https://docs.flutter.dev/platform-integration/web)

</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-this-repository">About this repository</a></li>
    <li><a href="#app-architecture-and-folder-structure">App architecture and folder structure</a></li>
    <li><a href="#packages">Packages</a></li>
    <li><a href="#previous-projects">Previous Projects</a></li>
    <li><a href="#starters">Starters</a></li>
    <li><a href="#badges">Badges</a></li>
    <li><a href="#coverage-pipeline">Coverage pipeline</a></li>
  </ol>
</details>

---

## About this repository

This repository is a playground for practicing Flutter.

Each folder is a standalone Flutter app. Topics include **Riverpod**, architecture, and other advanced Flutter subjects — without mixing everything into one project.

[![iOS](assets/badges/ios.svg)](https://developer.apple.com/ios/)
[![Web](assets/badges/web.svg)](https://docs.flutter.dev/platform-integration/web)

There is no Android project.

Copyable starters live in [app_starters](app_starters/).

The root README stays short: a link and a rough summary per project. Getting started and the detailed notes live in the README of that project.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## App architecture and folder structure

This is the approach every app in this playground follows. A small practice project may only fill `core/`, `features/`, and `l10n/`. A fuller app adds the extra `core/` and feature folders below. Not every folder has to exist from day one.

Platforms are **iOS** and **Web**. There is no Android project.

```
app/
├── ios/
├── web/
├── assets/
│   ├── coverage/
│   ├── img/
│   └── logo.png
├── lib/
│   ├── core/
│   │   ├── router/
│   │   ├── theme/
│   │   ├── errors/
│   │   ├── extensions/
│   │   ├── network/
│   │   └── utils/
│   ├── features/
│   │   └── feature_name/
│   │       ├── data/
│   │       │   ├── models/
│   │       │   ├── remote_services/
│   │       │   └── repositories/
│   │       ├── domain/
│   │       │   ├── entities/
│   │       │   ├── repositories/
│   │       │   └── use_cases/
│   │       └── presentation/
│   │           ├── providers/
│   │           ├── widgets/
│   │           └── feature_page.dart
│   ├── shared_widgets/
│   ├── l10n/
│   └── main.dart
├── test/
└── pubspec.yaml
```

### Feature-first

Code is grouped by **feature**, not by technical layer at the app root. A change in one feature should stay inside that folder.

### Layers

#### Data

- **models/** — API, JSON, or local shapes.
- **remote_services/** — network or Firebase calls.
- **repositories/** — implementations of the domain repository contracts. Map models to entities here.

#### Domain

- **entities/** — immutable business objects. No JSON, no Flutter widgets.
- **repositories/** — abstract contracts. Domain does not import data-layer files.
- **use_cases/** — only when the feature is large enough to need them.

#### Presentation

- **controllers/** — Riverpod notifiers and providers. Not Bloc.
- **widgets/** — feature-local UI.
- **feature_page.dart** — the screen for that feature.

`shared_widgets/` holds UI used by more than one feature. `ErrorWidget` is the async-error illustration plus message (`assets/img/` in the app that uses it). `core/` holds app-wide routing, theme, and similar infrastructure.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Packages

Packages currently used in the playground apps. Update this table when a `pubspec.yaml` changes.

| Package | Reason |
| --- | --- |
| [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) | State and dependency injection. `ProviderScope`, `ref.watch` / `ref.read`. |
| [go_router](https://pub.dev/packages/go_router) | Declarative routes for iOS and web. |
| [flutter_localizations](https://docs.flutter.dev/ui/internationalization) | Generated EN/DE l10n from ARB files. |
| [intl](https://pub.dev/packages/intl) | Message and date formatting used by l10n. |
| [very_good_analysis](https://pub.dev/packages/very_good_analysis) | Shared lint rules. |
| [FVM](https://fvm.app) | Pins the Flutter SDK per app (`.fvmrc`). |

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Previous Projects

<h3>
  <a href="riverpod_basics/">Riverpod Basics »</a>
  <a href="riverpod_basics/README.md#test-coverage"><img align="right" src="riverpod_basics/assets/coverage/badge.svg" alt="Coverage"></a>
</h3>

Practice app for **Riverpod**: no provider, `NotifierProvider`, AsyncNotifier Persistent / Non-Persistent State. `StateProvider` is the shortcut.

[README »](riverpod_basics/README.md)

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Starters

<h3>
  <a href="app_starters/riverpod_basic_starter/">Riverpod Basic Starter »</a>
  <a href="app_starters/riverpod_basic_starter/README.md#test-coverage"><img align="right" src="app_starters/riverpod_basic_starter/assets/coverage/badge.svg" alt="Coverage"></a>
</h3>

Copyable starter for **Riverpod**: GoRouter, l10n, feature folders, and a Material 3 seed theme.

[README »](app_starters/riverpod_basic_starter/README.md)

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Badges

Tech-stack and social badges live once in [`assets/badges/`](assets/badges/). After changing labels or colors:

```
python3 assets/badges/generate.py
```

Target URLs sit **on the badge line** (`[![Flutter](assets/badges/flutter.svg)](https://flutter.dev/)`). GitHub cannot import another file into a README, so there is no footer of `[flutter-url]:` refs. The href list is [`assets/badges/links.json`](assets/badges/links.json) when you add a badge.

Every badge is a vertical dark → mid → light gradient (same contrast as Instagram). The mid stop is the brand or playground color. Official colors stay official, except black — it is hard to see. Everything else uses purple, blue, turquoise, pink, or green — not black, orange, red, or yellow.

After you copy an app into its **own** git repo, copy `assets/badges/` there and point the README badge links at that path.

| File | Color (dark → mid → light) | Why |
| --- | --- | --- |
| `flutter.svg` | `#012F55` → `#02569B` → `#7BA7CB` | official Flutter |
| `dart.svg` | `#01406B` → `#0175C2` → `#7BB7DF` | official Dart |
| `riverpod.svg` | `#4C3469` → `#8B5FBF` → `#C3ACDE` | app purple |
| `gorouter.svg` | `#194C4A` → `#2D8A86` → `#92C2C0` | teal |
| `flutter_localizations.svg` | `#012F55` → `#02569B` → `#7BA7CB` | official Flutter |
| `intl.svg` | `#43345C` → `#7A5EA8` → `#BAABD2` | purple |
| `very_good.svg` | `#62184B` → `#B22C89` → `#D791C2` | Very Good Ventures |
| `fvm.svg` | `#17564F` → `#2A9D8F` → `#90CCC5` | turquoise |
| `ios.svg` | `#2A656C` → `#4DB8C4` → `#A2DAE0` | pastel turquoise |
| `web.svg` | `#0E4349` → `#1A7A84` → `#88BABF` | turquoise |
| `linkedin.svg` | `#06386B` → `#0A66C2` → `#80AFDF` | official LinkedIn |
| `instagram.svg` | `#4C3469` → `#8B5FBF` → `#C3ACDE` | lilac |
| `x.svg` | `#456576` → `#7EB8D6` → `#BCDAEA` | pastel light blue |

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Coverage pipeline

Scripts live once in [`coverage_pipeline/`](coverage_pipeline/). Each app still owns its own images under `assets/coverage/` and the percent in its README.

Badge color uses the same mid tones as the tech badges: **pink** (Very Good Analysis) below 60%, **purple** (Riverpod) from 60%, **blue** (Flutter) from 70%, **green** (GoRouter) from 80%.

This playground is one git repo. On **commit**, the playground hooks refresh **every** app in [`coverage_pipeline/playground_apps`](coverage_pipeline/playground_apps) and stage the SVGs in that same commit. On **push**, GitHub Actions (`.github/workflows/coverage.yml`) runs the same generator for every listed app so tests still run on Linux. CI **does not** commit or push badges — that extra bot commit was forcing a pull after every push. Pull requests run the same job; they do not write commits.

On commit the pipeline:

1. Runs `flutter test --coverage` in each listed app.
2. Adds any `lib/**/*.dart` the tests never loaded as **0 hits**. Dart coverage only records libraries the VM actually imported. An unused copy of a screen would otherwise leave the percent unchanged.
3. Turns `lcov.info` into two images: `assets/coverage/badge.svg` (header) and `assets/coverage/card.svg` (README card).
4. Writes the percent into that app's README.
5. Stages those files so they land in the **same** commit (`pre-commit`).
6. Runs the tests again on `git push` and blocks a failing push (`pre-push`).
7. GitHub Actions repeats steps 1–4 on push so Linux still runs the tests. It does **not** commit the result.

Install the playground hooks once:

```
./coverage_pipeline/install-git-hooks.sh
```

Refresh every app from the playground root:

```
./coverage_pipeline/update_all.sh
```

Refresh one app:

```
./coverage_pipeline/update_coverage.sh riverpod_basics
./coverage_pipeline/update_coverage.sh app_starters/riverpod_basic_starter
```

After you copy an app into its **own** git repo: copy `coverage_pipeline/` next to that repo's `pubspec.yaml`, copy [`coverage_pipeline/coverage.yml`](coverage_pipeline/coverage.yml) to `.github/workflows/coverage.yml`, and copy [`assets/logo.png`](assets/logo.png) plus [`assets/badges/`](assets/badges/) into that repo's `assets/`. Then:

```
./coverage_pipeline/install-git-hooks.sh
```

<p align="right"><a href="#readme-top">back to top</a></p>

