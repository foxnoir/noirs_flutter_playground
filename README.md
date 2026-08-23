<a name="readme-top"></a>

<!-- Top Links Bar -->

[![LinkedIn][linkedin-shield]][linkedin-url]
[![X][x-shield]][x-url]
[![Instagram][instagram-shield]][instagram-url]

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

<div align="center">

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

</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-this-repository">About this repository</a></li>
    <li><a href="#app-architecture-and-folder-structure">App architecture and folder structure</a></li>
    <li><a href="#packages">Packages</a></li>
    <li><a href="#previous-projects">Previous Projects</a></li>
    <li><a href="#starters">Starters</a></li>
    <li><a href="#coverage-pipeline">Coverage pipeline</a></li>
  </ol>
</details>

---

## About this repository

This repository is a playground for practicing Flutter.

Each folder is a standalone Flutter app. Topics include **Riverpod**, architecture, and other advanced Flutter subjects — without mixing everything into one project.

[![iOS][ios]][ios-url]
[![Web][web]][web-url]

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
│   │           ├── controllers/
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

`shared_widgets/` holds UI used by more than one feature. `core/` holds app-wide routing, theme, and similar infrastructure.

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

Practice app for **Riverpod** fundamentals: providers, `ConsumerWidget`, and reactive UI.

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

## Coverage pipeline

Scripts live once in [`coverage_pipeline/`](coverage_pipeline/). Each app still owns its own images under `assets/coverage/` and the percent in its README.

On commit the pipeline:

1. Runs `flutter test --coverage` in **that** app.
2. Turns `lcov.info` into two images: `assets/coverage/badge.svg` (header) and `assets/coverage/card.svg` (README card).
3. Writes the percent into that app's README.
4. Stages those files so they land in the **same** commit (`pre-commit`).
5. Runs the tests again on `git push` and blocks a failing push (`pre-push`).

Refresh one app from the playground root:

```
./coverage_pipeline/update_coverage.sh riverpod_basics
./coverage_pipeline/update_coverage.sh app_starters/riverpod_basic_starter
```

Git hooks and CI only after the folder is its **own** git repo. Copy `coverage_pipeline/` next to that repo's `pubspec.yaml`, copy [`coverage_pipeline/coverage.yml`](coverage_pipeline/coverage.yml) to `.github/workflows/coverage.yml`, and copy [`assets/logo.png`](assets/logo.png) plus [`assets/badges/`](assets/badges/) into that repo's `assets/`. Then:

```
./coverage_pipeline/install-git-hooks.sh
```

<p align="right"><a href="#readme-top">back to top</a></p>

---

[dart]: assets/badges/dart.svg
[dart-url]: https://dart.dev/
[flutter]: assets/badges/flutter.svg
[flutter-url]: https://flutter.dev/
[flutter-localizations]: assets/badges/flutter_localizations.svg
[flutter-localizations-url]: https://docs.flutter.dev/ui/internationalization
[fvm]: assets/badges/fvm.svg
[fvm-url]: https://fvm.app
[gorouter]: assets/badges/gorouter.svg
[gorouter-url]: https://pub.dev/packages/go_router
[instagram-shield]: assets/badges/instagram.svg
[instagram-url]: https://www.instagram.com/codeincouture/
[intl]: assets/badges/intl.svg
[intl-url]: https://pub.dev/packages/intl
[ios]: assets/badges/ios.svg
[ios-url]: https://developer.apple.com/ios/
[linkedin-shield]: assets/badges/linkedin.svg
[linkedin-url]: https://www.linkedin.com/in/tanja-polz-5636401a5/
[riverpod]: assets/badges/riverpod.svg
[riverpod-url]: https://pub.dev/packages/flutter_riverpod
[very-good]: assets/badges/very_good.svg
[very-good-url]: https://pub.dev/packages/very_good_analysis
[web]: assets/badges/web.svg
[web-url]: https://docs.flutter.dev/platform-integration/web
[x-shield]: assets/badges/x.svg
[x-url]: https://twitter.com/_foxnoir_?lang=de
