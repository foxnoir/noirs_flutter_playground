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
  <h1 align="center">Firebase in Depth</h1>
  <p>
     A deep dive into Firebase, using Flutter.
  </p>
</div>

---

<div align="left">

[![Flutter](../assets/badges/flutter.svg)](https://flutter.dev/)
[![Dart](../assets/badges/dart.svg)](https://dart.dev/)
[![Riverpod](../assets/badges/riverpod.svg)](https://pub.dev/packages/flutter_riverpod)
[![Riverpod Lint](../assets/badges/riverpod_lint.svg)](https://pub.dev/packages/riverpod_lint)
[![GoRouter](../assets/badges/gorouter.svg)](https://pub.dev/packages/go_router)
[![Flutter Localizations](../assets/badges/flutter_localizations.svg)](https://docs.flutter.dev/ui/internationalization)
[![Intl](../assets/badges/intl.svg)](https://pub.dev/packages/intl)
[![Firebase](../assets/badges/firebase.svg)](https://firebase.google.com/)
[![Very Good Analysis](../assets/badges/very_good.svg)](https://pub.dev/packages/very_good_analysis)
[![FVM](../assets/badges/fvm.svg)](https://fvm.app)
[![iOS](../assets/badges/ios.svg)](https://developer.apple.com/ios/)
[![Web](../assets/badges/web.svg)](https://docs.flutter.dev/platform-integration/web)

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
    <li><a href="#items-and-item-details">Items and Item Details</a></li>
  </ol>
</details>

---

## About

This project is the **Firebase** practice project in [Noir's Flutter Playground](../README.md). A deep dive into Firebase, using Flutter. State is [Riverpod](https://pub.dev/packages/flutter_riverpod). The app started from the [Riverpod Basic Starter](../app_starters/riverpod_basic_starter/README.md) shape: GoRouter, l10n, feature folders, sealed errors.

Labs will go into **Firestore** (CRUD, collection group queries, indexes, offline cache, performance guarantees), the **local emulator**, and **Storage** (photo upload). Those labs are not here yet. **Items** and **Item Details** are the working sample until they land. Two and Three stay as placeholder routes.

[![iOS](../assets/badges/ios.svg)](https://developer.apple.com/ios/)
[![Web](../assets/badges/web.svg)](https://docs.flutter.dev/platform-integration/web)

Runs on **iOS** (Simulator: **iPhone 17 Pro**, iOS 26.5) and **web**.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Features

- **iOS + Web**
- [Riverpod](https://pub.dev/packages/flutter_riverpod) (`ProviderScope`)
- [GoRouter](https://pub.dev/packages/go_router)
- l10n (English / German)
- Feature folders (`presentation` / `data` / `domain`)
- Sample **Items** list and **Item Details** (own feature, like User Details)
- Sealed `AppException` / `AppFailure` with l10n mapping
- Material 3 seed theme
- [Firebase](https://firebase.google.com/) (`firebase_core`, iOS app on `fir-in-depth-813e4`)
- Coverage badge and card

Coming: Firestore (CRUD, collection groups, performance), emulator, Storage / photo upload.

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
cd firebase_in_depth
fvm install
fvm flutter pub get
fvm flutter run
```

`fvm flutter run` uses the **iOS Simulator** (**iPhone 17 Pro**, iOS 26.5). Firebase is registered for **iOS** (`com.example.firebaseInDepth`). Web is not registered yet — `fvm flutter run -d chrome` still starts the UI, without `Firebase.initializeApp`.

This project is pinned with [FVM](https://fvm.app). After `fvm install`, Cursor uses the SDK at `.fvm/flutter_sdk`.

### Test coverage

<!-- coverage-percent:start -->
**76.5%** line coverage (208 of 272 lines).
<!-- coverage-percent:end -->

![Coverage](assets/coverage/card.svg)

The card and the header badge are regenerated on **playground commit** (git hooks at the repo root) when tests pass. A failing test does not block the commit; **push** still requires green tests (`pre-push`). GitHub Actions runs tests on Linux and does **not** commit the SVGs. `fvm flutter test --coverage` only writes local `lcov.info` for **Coverage Gutters**, and only for files the tests loaded. Unused `lib/` files are added as 0 hits when the playground generator runs. Saving a Dart file does not update the SVGs by itself.

```
cd firebase_in_depth
fvm flutter test --coverage
```

Or run the VS Code task **Flutter: Test with coverage**, then Command Palette → **Coverage Gutters: Display Coverage**.

How the badges are produced: playground [coverage pipeline](../README.md#coverage-pipeline).

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Errors

Thrown objects and UI copy are different types. No extra package: Dart 3 **`sealed class`** is enough.

- Data sources throw **`AppException`**: `NetworkException`, `NotFoundException`. Unknown errors are wrapped here.
- Repositories catch **`on AppException`** and `throw AppFailure.fromException(e)`. No dartz — throwing the failure is `Left`.
- Notifiers store that `AppFailure`. They do not map.
- UI calls **`failure.message(l10n)`** or **`localizedError(l10n, error)`**. Never `toString()`.

Files: `lib/core/errors/`. Copy lives in ARB (`errorNetwork`, `errorNotFound`, `errorOccurred`). **`ErrorWidget`** (`lib/shared_widgets/error_widget.dart`) is the shared error screen (icon + message + optional retry). Import material with `hide ErrorWidget`.

**Items** and **Item Details** are the working example: `InMemoryItemDataSource` throws `AppException`; `InMemoryItemRepository` maps to `AppFailure`; the list and details notifiers store `AsyncError`; the UI calls `localizedError`.

Form validation is not a fetch failure. Keep those as field/form strings.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Items and Item Details

**Items** is the list. **Item Details** is its own feature — same idea as User Details in Advanced Concepts. Data stays in Items (`InMemoryItemDataSource` → `InMemoryItemRepository`). Details watches `itemDetailsProvider` and reads that repository. Screens are `ItemsScreen` / `ItemDetailsScreen`. Feature-local UI lives in `presentation/widgets/` (`ItemsRow`, `ItemDetailsMetadata`, `ItemDetailsData`).

Layers match the playground [folder structure](../README.md#app-architecture-and-folder-structure).

- **Data source** — fake GET. Returns `ItemModel`. Throws `NetworkException` / `NotFoundException`.
- **Repository** — `on AppException` → `AppFailure.fromException`. Models → `Item` entities. Throws `AppFailure`.
- **Notifier** — `AsyncNotifier` / family. Stores `AsyncValue`. Does not map.
- **UI** — `when(loading, error, data)`. `ErrorWidget` + Retry.

Tests fake the **repository** (`AppFailure`) or the **data source** (`AppException`) depending on which layer they cover.

<p align="right"><a href="#readme-top">back to top</a></p>
