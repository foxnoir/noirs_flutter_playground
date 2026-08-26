<a name="readme-top"></a>

<!-- Top Links Bar -->

<a href="#test-coverage"><img align="right" src="assets/coverage/badge.svg" alt="Coverage"></a>

[![LinkedIn](../../assets/badges/linkedin.svg)](https://www.linkedin.com/in/tanja-polz-5636401a5/)
[![X](../../assets/badges/x.svg)](https://twitter.com/_foxnoir_?lang=de)
[![Instagram](../../assets/badges/instagram.svg)](https://www.instagram.com/codeincouture/)

<!-- PROJECT LOGO -->
<br />

<div align="center">
  <img src="../../assets/logo.png" alt="Logo" width="179" height="179">
  <h1 align="center">Riverpod Basic Starter</h1>
  <p>
     Starter for Riverpod — copy this app when you begin a new project.
  </p>
</div>

---

<div align="left">

[![Flutter](../../assets/badges/flutter.svg)](https://flutter.dev/)
[![Dart](../../assets/badges/dart.svg)](https://dart.dev/)
[![Riverpod](../../assets/badges/riverpod.svg)](https://pub.dev/packages/flutter_riverpod)
[![GoRouter](../../assets/badges/gorouter.svg)](https://pub.dev/packages/go_router)
[![Flutter Localizations](../../assets/badges/flutter_localizations.svg)](https://docs.flutter.dev/ui/internationalization)
[![Intl](../../assets/badges/intl.svg)](https://pub.dev/packages/intl)
[![Very Good Analysis](../../assets/badges/very_good.svg)](https://pub.dev/packages/very_good_analysis)
[![FVM](../../assets/badges/fvm.svg)](https://fvm.app)
[![iOS](../../assets/badges/ios.svg)](https://developer.apple.com/ios/)
[![Web](../../assets/badges/web.svg)](https://docs.flutter.dev/platform-integration/web)

</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about">About</a></li>
    <li><a href="#features">Features</a></li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#test-coverage">Test coverage</a></li>
      </ul>
    </li>
    <li><a href="#errors">Errors</a></li>
    <li><a href="#items-feature">Items feature</a></li>
  </ol>
</details>

---

## About

This is a **Riverpod** starter in [Noir's Flutter Playground](../../README.md). Copy the folder and rename the Dart package.

**Items** is the copyable feature: data source, repository, model, entity, list, and detail. Two and Three stay as placeholder routes.

[![iOS](../../assets/badges/ios.svg)](https://developer.apple.com/ios/)
[![Web](../../assets/badges/web.svg)](https://docs.flutter.dev/platform-integration/web)

There is no Android project. Run on the iOS Simulator or Chrome.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Features

- **iOS + Web** (no Android)
- [Riverpod](https://pub.dev/packages/flutter_riverpod) (`ProviderScope`)
- [GoRouter](https://pub.dev/packages/go_router)
- l10n (English / German)
- Feature folders (`presentation` / `data` / `domain`)
- Sample **Items** feature (data source, repository, model, entity)
- Sealed `AppException` / `AppFailure` with l10n mapping
- Material 3 seed theme
- [FVM](https://fvm.app) pin
- Coverage badge and card

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
cd app_starters/riverpod_basic_starter
fvm install
fvm flutter pub get
fvm flutter run
```

`fvm flutter run` uses the **iOS Simulator**. For web, use `fvm flutter run -d chrome`. There is no Android project.

This project is pinned with [FVM](https://fvm.app). After `fvm install`, Cursor uses the SDK at `.fvm/flutter_sdk`.

### Test coverage

<!-- coverage-percent:start -->
**79.9%** line coverage (195 of 244 lines).
<!-- coverage-percent:end -->

![Coverage](assets/coverage/card.svg)

The card and the header badge are regenerated on **playground commit** (git hooks at the repo root) when tests pass. A failing test does not block the commit; **push** still requires green tests (`pre-push`). GitHub Actions runs tests on Linux and does **not** commit the SVGs. `fvm flutter test --coverage` only writes local `lcov.info` for **Coverage Gutters**, and only for files the tests loaded. Unused `lib/` files are added as 0 hits when the playground generator runs. Saving a Dart file does not update the SVGs by itself.

```
cd app_starters/riverpod_basic_starter
fvm flutter test --coverage
```

Or run the VS Code task **Flutter: Test with coverage**, then Command Palette → **Coverage Gutters: Display Coverage**.

How the badges are produced: playground [coverage pipeline](../../README.md#coverage-pipeline).

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Errors

Thrown objects and UI copy are different types. No extra package: Dart 3 **`sealed class`** is enough.

- Data sources throw **`AppException`**: `NetworkException`, `NotFoundException`. Unknown errors are wrapped here.
- Repositories catch **`on AppException`** and `throw AppFailure.fromException(e)`. No dartz — throwing the failure is `Left`.
- Notifiers store that `AppFailure`. They do not map.
- UI calls **`failure.message(l10n)`** or **`localizedError(l10n, error)`**. Never `toString()`.

Files: `lib/core/errors/`. Copy lives in ARB (`errorNetwork`, `errorNotFound`, `errorOccurred`). **`ErrorWidget`** (`lib/shared_widgets/error_widget.dart`) is the shared error screen (icon + message + optional retry). Import material with `hide ErrorWidget`.

The **Items** feature is the working example: `InMemoryItemDataSource` throws `AppException`; `InMemoryItemRepository` maps to `AppFailure`; the list/detail notifiers store `AsyncError`; the UI calls `localizedError`.

Form validation is not a fetch failure. Keep those as field/form strings.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Items feature

Copy `lib/features/items/` when you add a real feature. Rename the types.

```text
lib/features/items/
├── data/
│   ├── models/item_model.dart
│   ├── data_sources/in_memory_item_data_source.dart
│   └── repositories/in_memory_item_repository.dart
├── domain/
│   ├── entities/item.dart
│   └── repositories/item_repository.dart
└── presentation/
    ├── providers/item_list_provider.dart
    ├── providers/item_provider.dart
    ├── items_page.dart
    └── item_detail_page.dart
```

- **Data source** — fake GET. Returns `ItemModel`. Throws `NetworkException` / `NotFoundException`.
- **Repository** — `on AppException` → `AppFailure.fromException`. Models → `Item` entities. Throws `AppFailure`.
- **Notifier** — `AsyncNotifier` / family. Stores `AsyncValue`. Does not map.
- **UI** — `when(loading, error, data)`. `ErrorWidget` + Retry.

Tests fake the **repository** (`AppFailure`) or the **data source** (`AppException`) depending on which layer they cover.

<p align="right"><a href="#readme-top">back to top</a></p>

