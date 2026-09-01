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
     Practice projects for Flutter — Riverpod, navigation, layout, lists, and architecture.
  </p>
</div>

---

<div align="left">

[![Flutter](assets/badges/flutter.svg)](https://flutter.dev/)
[![Dart](assets/badges/dart.svg)](https://dart.dev/)
[![Riverpod](assets/badges/riverpod.svg)](https://pub.dev/packages/flutter_riverpod)
[![Riverpod Lint](assets/badges/riverpod_lint.svg)](https://pub.dev/packages/riverpod_lint)
[![Freezed](assets/badges/freezed.svg)](https://pub.dev/packages/freezed)
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
    <li>
      <a href="#coverage-pipeline">Coverage pipeline</a>
      <ul>
        <li><a href="#what-it-does">What it does</a></li>
        <li><a href="#files">Files</a></li>
        <li><a href="#install-in-this-playground">Install in this playground</a></li>
        <li><a href="#cursor-source-control">Cursor Source Control</a></li>
        <li><a href="#wire-an-app">Wire an app</a></li>
        <li><a href="#add-another-playground-app">Add another playground app</a></li>
        <li><a href="#copy-an-app-into-its-own-repo">Copy an app into its own repo</a></li>
      </ul>
    </li>
  </ol>
</details>

---

## About this repository

This repository is a playground for practicing Flutter.

Each folder is a standalone practice project. Topics include **Riverpod**, **navigation**, **layout**, **lists**, and architecture — without mixing everything into one project.

[![iOS](assets/badges/ios.svg)](https://developer.apple.com/ios/)
[![Web](assets/badges/web.svg)](https://docs.flutter.dev/platform-integration/web)

There is no Android project. The iOS Simulator is **iPhone 17 Pro** (iOS 26.5).

Copyable starters live in [app_starters](app_starters/).

The root README stays short: a link and a rough summary per project. Getting started and the detailed notes live in the README of that project.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## App architecture and folder structure

This is the approach every app in this playground follows. A small practice project may only fill `core/`, `features/`, and `l10n/`. A fuller app adds the extra `core/` and feature folders below. Not every folder has to exist from day one.

Platforms are **iOS** and **Web**. There is no Android project. The iOS Simulator is **iPhone 17 Pro** (iOS 26.5).

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
│   │       │   ├── data_sources/   # or remote_services/ — throw AppException
│   │       │   ├── remote_services/
│   │       │   └── repositories/   # map AppException → AppFailure, models → entities
│   │       ├── domain/
│   │       │   ├── entities/
│   │       │   ├── repositories/
│   │       │   └── use_cases/
│   │       └── presentation/
│   │           ├── providers/
│   │           ├── widgets/
│   │           └── feature_screen.dart
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
- **data_sources/** / **remote_services/** — GET, prefs, Firebase. Throw `AppException`. Return models, not entities.
- **repositories/** — implementations of the domain repository contracts. Map models to entities. Catch `on AppException` and `throw AppFailure.fromException(e)` (dartz equivalent: `Left(ApiFailure.fromException(e))`).

#### Domain

- **entities/** — immutable business objects. No JSON, no Flutter widgets.
- **repositories/** — abstract contracts. Domain does not import data-layer files.
- **use_cases/** — only when the feature is large enough to need them.

#### Presentation

- **providers/** — Riverpod notifiers and providers. Not Bloc.
- **widgets/** — feature-local UI.
- **feature_screen.dart** — the screen for that feature (`*Screen`). Riverpod Basics landing is still `LandingPage`.

`shared_widgets/` holds UI used by more than one feature. `ErrorWidget` is the async-error UI (illustration or icon, message, optional retry). `LabInfoText` renders `**bold**` paragraphs from ARB copy (both practice projects). Advanced Concepts also has `CodeSnippet` (monospace Dart), `NavStackPreview` (stack diagram on User List / User Details), `LabCompareFrame` (wrong vs works), `LabErrorStripes` (Flutter-style overflow paint without crashing the page), and `LabScreenBody` (`LayoutBuilder` caps width at 840 for web). `core/` holds app-wide routing, theme, and similar infrastructure. Breakpoints are `AppBreakpoint` in `core/theme/` (Material 3: compact below 600, medium 600, expanded 840, large 1200, extra-large 1600) — not AdaptiveScaffold. `core/errors/` is sealed `AppException` / `AppFailure`, the mapper, and l10n message helpers — not Equatable failure classes.

Data sources and repositories are named after the feature: `InMemoryUserListDataSource`, `InMemoryUserListRepository` (not a generic `UserRepository`).

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Packages

Packages currently used in the playground apps. Update this table when a `pubspec.yaml` changes.

| Package | Reason |
| --- | --- |
| [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) | State and dependency injection. `ProviderScope`, `ref.watch` / `ref.read`. |
| [riverpod_annotation](https://pub.dev/packages/riverpod_annotation) | `@riverpod` annotations for `riverpod_generator`. |
| [freezed_annotation](https://pub.dev/packages/freezed_annotation) | Annotations for immutable Freezed models. |
| [json_annotation](https://pub.dev/packages/json_annotation) | Annotations for `fromJson` / `toJson` codegen. |
| [go_router](https://pub.dev/packages/go_router) | Declarative routes for iOS and web. |
| [http](https://pub.dev/packages/http) | Real HTTP in API Handling → General (`ApiClient`). |
| [flutter_localizations](https://docs.flutter.dev/ui/internationalization) | Generated EN/DE l10n from ARB files. |
| [intl](https://pub.dev/packages/intl) | Message and date formatting used by l10n. |
| [freezed](https://pub.dev/packages/freezed) | Codegen for immutable models and unions (`dev`). |
| [json_serializable](https://pub.dev/packages/json_serializable) | JSON codegen used with Freezed (`dev`). |
| [riverpod_generator](https://pub.dev/packages/riverpod_generator) | Generates providers from `@riverpod` (`dev`). |
| [riverpod_lint](https://pub.dev/packages/riverpod_lint) | Riverpod analyzer plugin (`dev`). |
| [build_runner](https://pub.dev/packages/build_runner) | Runs the code generators (`dev`). |
| [very_good_analysis](https://pub.dev/packages/very_good_analysis) | Shared lint rules. |
| [FVM](https://fvm.app) | Pins the Flutter SDK per app (`.fvmrc`). |

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Previous Projects

<h3>
  <a href="riverpod_basics/">Riverpod Basics »</a>
  <a href="riverpod_basics/README.md#test-coverage"><img align="right" src="riverpod_basics/assets/coverage/badge.svg" alt="Coverage"></a>
</h3>

Practice project for **Riverpod**: provider types, labs (listen, ConsumerWidget, Quote, Tick, Auth, refresh / invalidate, AutoDispose lifetimes, User List with data source + repository, Add User, User Search), Freezed, and sealed error mapping.

[README »](riverpod_basics/README.md)

<h3>
  <a href="advanced_concepts/">Advanced Concepts »</a>
  <a href="advanced_concepts/README.md#test-coverage"><img align="right" src="advanced_concepts/assets/coverage/badge.svg" alt="Coverage"></a>
</h3>

Practice project for **navigation**, **layout**, **lists**, and **API integration**: go, push, pop, replace; Flexible vs Expanded, PreferredSize, LayoutBuilder vs MediaQuery; ListView / GridView / slivers; unified API class, timeouts, and network errors.

[README »](advanced_concepts/README.md)

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Starters

<h3>
  <a href="app_starters/riverpod_basic_starter/">Riverpod Basic Starter »</a>
  <a href="app_starters/riverpod_basic_starter/README.md#test-coverage"><img align="right" src="app_starters/riverpod_basic_starter/assets/coverage/badge.svg" alt="Coverage"></a>
</h3>

Copyable starter for **Riverpod**: GoRouter, l10n, a sample Items feature (data source, repository, entities), sealed failures, and a Material 3 seed theme.

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
| `riverpod_lint.svg` | `#343A5C` → `#5E6AA8` → `#ABB2D2` | blue-violet |
| `freezed.svg` | `#294D3D` → `#4A8C6F` → `#A1C3B4` | green |
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
| `firebase.svg` | `#02557E` → `#039BE5` → `#7CCBF1` | Firebase blue (replaces yellow/orange) |

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Coverage pipeline

Scripts live once in [`coverage_pipeline/`](coverage_pipeline/). Each app still owns its own images under `assets/coverage/` and the percent in its README.

Badge color uses the same mid tones as the tech badges: **pink** (Very Good Analysis) below 60%, **purple** (Riverpod) from 60%, **blue** (Flutter) from 70%, **green** (GoRouter) from 80%. GitHub Camo may keep an old header SVG for a while; the **Test coverage** percent in that app’s README is the source of truth.

### What it does

This playground is one git repo. On **commit**, the playground hook runs tests and refreshes coverage for every app in [`coverage_pipeline/playground_apps`](coverage_pipeline/playground_apps), then stages the SVGs in that same commit. If tests fail, the commit still goes through and badges stay as they were — fix tests before **push**. **Push** runs `flutter test` again and **blocks** if anything fails (`pre-push`). A failed push prints the test name, a re-run command, and writes `.git/pre-push-test.log` — GitLens often hides the compact test output, so that summary is the thing to read. GitHub Actions (`.github/workflows/coverage.yml`) runs tests on Linux. CI **does not** commit or push badges.

On commit (when tests pass):

1. Runs `flutter test --coverage` in each listed app.
2. Adds any `lib/**/*.dart` the tests never loaded as **0 hits**. Dart coverage only records libraries the VM actually imported. An unused copy of a screen would otherwise leave the percent unchanged.
3. Turns `lcov.info` into two images: `assets/coverage/badge.svg` (header) and `assets/coverage/card.svg` (README card).
4. Writes the percent into that app's README.
5. Stages those files so they land in the **same** commit (`pre-commit`).
6. On **push**, runs the tests again and blocks a failing push (`pre-push`). The hook prints which test failed.
7. GitHub Actions runs the same tests on Linux. It does **not** commit the result.

`.git/hooks/` is **not** committed. After a fresh clone, install the links again.

### Files

| Path | Role |
| --- | --- |
| [`coverage_pipeline/playground_apps`](coverage_pipeline/playground_apps) | One relative app path per line. Playground hooks and CI iterate this list. |
| [`coverage_pipeline/update_coverage.sh`](coverage_pipeline/update_coverage.sh) | Tests one Flutter app with coverage and writes its SVGs + README percent. Needs `python3`. |
| [`coverage_pipeline/update_all.sh`](coverage_pipeline/update_all.sh) | Runs `update_coverage.sh` for every path in `playground_apps`. |
| [`coverage_pipeline/coverage_badge.py`](coverage_pipeline/coverage_badge.py) | Builds `badge.svg` / `card.svg` and replaces the README percent markers. |
| [`coverage_pipeline/install-git-hooks.sh`](coverage_pipeline/install-git-hooks.sh) | Symlinks scripts into `.git/hooks/pre-commit` and `pre-push`. |
| [`coverage_pipeline/git-hooks/playground-pre-commit`](coverage_pipeline/git-hooks/playground-pre-commit) | Playground commit hook: refresh every listed app; **does not** block the commit if tests fail. |
| [`coverage_pipeline/run_flutter_tests.sh`](coverage_pipeline/run_flutter_tests.sh) | Runs `flutter test` for one app. On failure prints the test name, a re-run command, and `.git/pre-push-test.log`. |
| [`coverage_pipeline/git-hooks/playground-pre-push`](coverage_pipeline/git-hooks/playground-pre-push) | Playground push hook: tests every listed app; **blocks** the push if anything fails. |
| [`coverage_pipeline/git-hooks/pre-commit`](coverage_pipeline/git-hooks/pre-commit) | Single-app repo commit hook (copied-out app). **Blocks** the commit if tests fail. |
| [`coverage_pipeline/git-hooks/pre-push`](coverage_pipeline/git-hooks/pre-push) | Single-app repo push hook: blocks the push if tests fail. |
| [`coverage_pipeline/cursor-git`](coverage_pipeline/cursor-git) | Git wrapper so Cursor Source Control actually runs hooks (see below). |
| [`coverage_pipeline/coverage.yml`](coverage_pipeline/coverage.yml) | Workflow template for a copied-out single-app repo. |
| [`.github/workflows/coverage.yml`](.github/workflows/coverage.yml) | This playground’s workflow: `update_all.sh` on Linux, **no** badge commit. |
| `<app>/assets/coverage/badge.svg` | Small header badge. |
| `<app>/assets/coverage/card.svg` | README card. |
| `<app>/README.md` | Percent block between HTML comments (see [Wire an app](#wire-an-app)). |

### Install in this playground

From the repo root, once per clone:

```
./coverage_pipeline/install-git-hooks.sh
```

That links:

```
.git/hooks/pre-commit  →  coverage_pipeline/git-hooks/playground-pre-commit
.git/hooks/pre-push    →  coverage_pipeline/git-hooks/playground-pre-push
```

Refresh every app from the playground root (same as the commit hook, without committing):

```
./coverage_pipeline/update_all.sh
```

One app:

```
./coverage_pipeline/update_coverage.sh riverpod_basics
./coverage_pipeline/update_coverage.sh app_starters/riverpod_basic_starter
./coverage_pipeline/update_coverage.sh advanced_concepts
```

### Cursor Source Control

Cursor Source Control injects `core.hooksPath=/dev/null`, so hooks never run from the **Changes** panel. Cursor also **ignores** `git.path` in workspace `.vscode/settings.json`.

Set **User** Settings:

```json
"git.path": "/absolute/path/to/noirs_flutter_playground/coverage_pipeline/cursor-git"
```

Then **Developer: Reload Window**. A terminal `git commit` / `git push` always runs the hooks. The wrapper strips Cursor’s override and, on `git push`, runs `pre-push` itself so a test failure shows `pre-push blocked — tests failed in …` instead of Cursor’s “Try running Pull first”. GitLens still may open a retry terminal with only `git push`; the failing test is in that hook output and in `.git/pre-push-test.log`.

### Wire an app

Each app that should get badges needs:

1. `pubspec.yaml` and a normal `test/` tree.
2. Folder `assets/coverage/` (the generator creates the SVGs).
3. In that app’s `README.md`, a percent block the Python script can replace:

```html
<!-- coverage-percent:start -->
**0%** line coverage (0 of 0 lines).
<!-- coverage-percent:end -->

![Coverage](assets/coverage/card.svg)
```

4. Optional header badge (same file GitHub may cache):

```html
<a href="#test-coverage"><img align="right" src="assets/coverage/badge.svg" alt="Coverage"></a>
```

### Add another playground app

1. Put the app somewhere under this repo (for example `my_app/`).
2. Wire its README as above.
3. Append the relative path to [`coverage_pipeline/playground_apps`](coverage_pipeline/playground_apps) (one path per line, no leading `./`).
4. Commit. The playground `pre-commit` hook will test that app and stage its SVGs with the rest.

### Copy an app into its own repo

Copy `coverage_pipeline/` next to that repo’s `pubspec.yaml`, copy [`coverage_pipeline/coverage.yml`](coverage_pipeline/coverage.yml) to `.github/workflows/coverage.yml`, and copy [`assets/logo.png`](assets/logo.png) plus [`assets/badges/`](assets/badges/) into that repo’s `assets/`. Then:

```
./coverage_pipeline/install-git-hooks.sh
```

That links the **single-app** hooks (`git-hooks/pre-commit`, `git-hooks/pre-push`). There the commit hook **does** block if tests fail, and CI checks that the committed SVGs match a fresh generate (`git diff --exit-code`).

<p align="right"><a href="#readme-top">back to top</a></p>

