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
[![Freezed](../assets/badges/freezed.svg)](https://pub.dev/packages/freezed)
[![GoRouter](../assets/badges/gorouter.svg)](https://pub.dev/packages/go_router)
[![Flutter Localizations](../assets/badges/flutter_localizations.svg)](https://docs.flutter.dev/ui/internationalization)
[![Intl](../assets/badges/intl.svg)](https://pub.dev/packages/intl)
[![Firebase](../assets/badges/firebase.svg)](https://firebase.google.com/)
[![Firestore](../assets/badges/firestore.svg)](https://firebase.google.com/docs/firestore)
[![Very Good Analysis](../assets/badges/very_good.svg)](https://pub.dev/packages/very_good_analysis)
[![FVM](../assets/badges/fvm.svg)](https://fvm.app)
[![Web](../assets/badges/web.svg)](https://docs.flutter.dev/platform-integration/web)
[![iOS](../assets/badges/ios.svg)](https://developer.apple.com/ios/)

</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about">About</a></li>
    <li><a href="#features">Features</a></li>
    <li>
      <a href="#firestore">Firestore</a>
      <ul>
        <li><a href="#documents-and-collections">Documents and collections</a></li>
        <li><a href="#primary-key-versus-unique-identifier">Primary key versus unique identifier</a></li>
        <li><a href="#large-collection-of-small-documents">Large collection of small documents</a></li>
        <li><a href="#nested-collections">Nested collections</a></li>
        <li><a href="#nested-versus-two-root-collections">Nested versus two root collections</a></li>
        <li><a href="#courses-in-this-project">Courses in this project</a></li>
        <li><a href="#freezed">Freezed</a></li>
      </ul>
    </li>
    <li>
      <a href="#web-first">Web first</a>
      <ul>
        <li><a href="#inspecting-responses">Inspecting responses</a></li>
      </ul>
    </li>
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

The Firestore collection [`courses`](https://console.firebase.google.com/project/fir-in-depth-813e4/firestore/databases/-default-/data/~2Fcourses) is seeded (Japanese courses, nested `tutor` map). Flutter CRUD, collection group queries, indexes, offline cache, the **local emulator**, and **Storage** (photo upload) are not wired yet. **Items** and **Item Details** are the working sample until they land. Two and Three stay as placeholder routes.

[![Web](../assets/badges/web.svg)](https://docs.flutter.dev/platform-integration/web)
[![iOS](../assets/badges/ios.svg)](https://developer.apple.com/ios/)

**Web first** (Chrome). iOS Simulator still runs. The browser document title is **Firebase in Depth** (`web/index.html` `<title>`, `onGenerateTitle`).

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Features

- **Web first** (Chrome), plus iOS
- [Riverpod](https://pub.dev/packages/flutter_riverpod) (`ProviderScope`)
- [GoRouter](https://pub.dev/packages/go_router)
- l10n (English / German)
- Feature folders (`presentation` / `data` / `domain`)
- Sample **Items** list and **Item Details** (own feature, like User Details)
- Sealed `AppException` / `AppFailure` with l10n mapping
- [Freezed](https://pub.dev/packages/freezed) for Firestore models (`Course` / `Tutor`; not the Items sample)
- Material 3 seed theme
- [Firebase](https://firebase.google.com/) (`firebase_core`, web + iOS on `fir-in-depth-813e4`)
- [Firestore](https://firebase.google.com/docs/firestore) collection `courses` (seeded; app does not read it yet)
- [FVM](https://fvm.app) pin
- Coverage badge and card

Coming: Firestore CRUD in the app, collection groups, emulator, Storage / photo upload.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Firestore

[Data model](https://firebase.google.com/docs/firestore/data-model): collections hold documents. Documents hold fields. That is the whole tree.

### Documents and collections

A **document** is one record. It has an ID (`hiragana-from-zero`) and a map of fields (`description`, `tutor`, …). You read and write the document as a whole. Max size is **1 MiB**. An empty document can still exist as a path so a subcollection has a parent.

A **collection** is a named list of documents (`courses`). It does not store fields of its own. It is not created up front — it appears when the first document is written, and it disappears when the last one is gone.

The path always alternates: `collection / document / collection / document`. You cannot put a collection inside a collection, or a document inside a document.

### Primary key versus unique identifier

SQL gives you both: a **primary key** (the row's identity) and extra **UNIQUE** columns (email, slug) that the database rejects on duplicate.

Firestore only guarantees uniqueness for the **document ID**, and only **inside that collection**. That ID is the primary key analogue. There is no UNIQUE constraint on a field. Two courses may both have `url: "hiragana-from-zero"`; Firestore will not care.

If a value must be unique, **make it the document ID**. This seed uses the slug (`hiragana-from-zero`) as the ID. The `url` field copies that slug for the app — it is not a second unique key. Auto-IDs (`Bir3OG4ZSoyMRAOSg9MB`) are unique and opaque. Fine when you have no natural key. Awkward in URLs and in teaching paths.

Uniqueness does not cross collections. `lessons/vowels` under Hiragana and `lessons/vowels` under Kanji are different documents. A unique email in `users` means the document ID *is* the email (or a lookup collection), not a `email` field with a unique index.

### Large collection of small documents

Firestore is built for **many small documents**, not one fat document that contains a list of everything.

A course with 200 lessons as an array on the course document would hit the size cap, download all lessons when you only wanted the title, and make every write contend on that one doc. Prefer `courses` (eight small course docs) and later `lessons` as their own documents. List queries + `limit` / `startAfter` then load a page, not the world.

Small, bounded arrays on a document are still fine (`categories`, `tutor.employedSince`). Unbounded lists are not.

### Nested collections

A document may have **subcollections**. The children are not fields on the parent. They live at a nested path:

```text
courses / hiragana-from-zero                 ← course: slug is the document ID
courses / hiragana-from-zero / lessons / {autoId}
```

Course IDs are slugs (`hiragana-from-zero`) — a natural unique identifier. Lesson IDs are **auto-generated**. A lesson has no stable unique key of its own; `seqNo` is only order inside that course, not an ID. Click the lesson in the console to open the **fourth** column (`description`, `duration`, `seqNo`). The collection list shows IDs only.

Some courses have a `lessons` subcollection (Hiragana, Kanji, Keigo). The others do not — a missing nested collection is normal, not an error. `lessonsCount` on the course matches the seeded lesson docs. Deleting the course document does **not** delete `lessons`. Collection group queries (`collectionGroup('lessons')`) are the later lab: one query across every course's `lessons`.

### Nested versus two root collections

Nest when the child **cannot exist without** the parent. A lesson is not a standalone catalog item — it belongs to one course. Path `courses/{id}/lessons/{lessonId}` is the ownership. The usual query is “lessons of this course”; security rules can match that path. You do not need a `courseId` field for that.

Use **two root collections** when both entities have their own life. `users` and `courses` stay siblings: a user is not deleted with a course. Same if you mostly list *all* lessons in the project with no course in hand — that is either a [collection group](https://firebase.google.com/docs/firestore/query-data/queries#collection-group-query) or a root `lessons` collection plus `courseId`. Do not nest only to make the console look tidy.

“Cannot exist without” is a **domain** rule. Firestore has no foreign key and no cascade delete. If you remove a course, delete its `lessons` yourself (or with a Function).

### Courses in this project

This playground still keeps **the same fields on every course**. Firestore is **schemaless** — two documents in `courses` *may* have different fields, missing keys, or different types for the same name. The database will not stop you. Queries (`orderBy('seqNo')`), Dart models, and the UI should not have to guess whether `tutor` or `price` exists. Different schemas are a lab later (optional fields, migration), not the seed.

| Field | Type | Notes |
|---|---|---|
| `description` | string | Short title |
| `longDescription` | string | One paragraph |
| `url` | string | Same as the document ID |
| `seqNo` | number | List order / pagination cursor. Keep it a number, not `"1"`. |
| `lessonsCount` | number | Denormalized. Do not count a subcollection on every list read. |
| `price` | number | |
| `categories` | array of string | Small and bounded, e.g. `BEGINNER` |
| `icon` | string | `purple` / `light_purple` / `green` / `turquoise` → `assets/icons/courses/course_$icon.png` |
| `tutor` | map | Nested object: `name` (string), `employedSince` (array `[year, month, day]`) |

Lesson documents (where the subcollection exists) — three fields only, same shape as a typical Firestore course sample:

| Field | Type | Notes |
|---|---|---|
| `description` | string | Lesson title |
| `duration` | string | `MM:SS`, e.g. `06:05` |
| `seqNo` | number | Order inside that course. Not a unique identifier. |

Lesson document IDs are auto-generated. No `url` / `courseId` on the lesson. The parent path is the course.

**Keep arrays short.** A document is downloaded as a whole (max 1 MiB). `array-contains` is for small, stable lists. Do not grow an unbounded array on the course (`lessons`, comments, students). Those belong in a **subcollection**. `Timestamp` is the type you want when you start range-querying dates.

### Freezed

Same fields on every course is what makes a Freezed class practical: `Course` + nested `Tutor`, `fromJson` via **json_serializable** for the Firestore map. Packages land with that feature. How codegen works (and when *not* to use Freezed) is in [Riverpod Basics → Freezed](../riverpod_basics/README.md#freezed).

Use it for document shapes and for UI state that is more than one field. Do not Freezed a widget, a repository, or a single `String`. The **Items** sample stays handwritten until Courses replace it.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Web first

This app is meant to be run in **Chrome**, so Firestore traffic is visible. The document title in the tab is **Firebase in Depth**.

```
cd firebase_in_depth
fvm flutter run -d chrome
```

Or the VS Code / Cursor launch config **Firebase in Depth** (Chrome). **Firebase in Depth (iOS)** is the Simulator.

### Inspecting responses

**Web (use this).** Chrome DevTools → **Network**. Filter `firestore`. The web SDK talks HTTPS to `firestore.googleapis.com` (Listen / channel). You see status, timing, and payload. The payload is not a pretty REST JSON document — it is the SDK wire format. The [Console](https://console.firebase.google.com/project/fir-in-depth-813e4/firestore/databases/-default-/data/~2Fcourses) is still the place to *read* fields. DevTools is the place to see *that a request happened*.

**iOS Simulator.** The native SDK uses gRPC, not the browser. Safari Web Inspector and Flutter DevTools Network do not show those calls. A proxy (Proxyman / Charles) can, with TLS hassle. For watching Firestore, stay on web.

Widget tests skip `Firebase.initializeApp` (VM is neither web nor iOS).

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
fvm flutter run -d chrome
```

**Web first.** `fvm flutter run -d chrome` initializes Firebase for web. Launch config **Firebase in Depth** is Chrome; **Firebase in Depth (iOS)** is the Simulator (**iPhone 17 Pro**, iOS 26.5). See [Web first](#web-first) for DevTools.

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
