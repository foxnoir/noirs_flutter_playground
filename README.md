<a name="readme-top"></a>

<!-- Top Links Bar -->

[![LinkedIn][linkedin-shield]][linkedin-url]
[![X][x-shield]][x-url]
[![Instagram][instagram-shield]][instagram-url]

<!-- PROJECT LOGO -->
<br />

<div align="center">
  <img src="assets/logo.png" alt="Logo" width="80" height="80">
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

## Previous Projects

### [Riverpod Basics »](riverpod_basics/)

<p align="center">Practice app for <strong>Riverpod</strong> fundamentals: providers, <code>ConsumerWidget</code>, and reactive UI.</p>

<div align="center">

[![Coverage](riverpod_basics/assets/coverage/badge.svg)](riverpod_basics/README.md#test-coverage)

[README »](riverpod_basics/README.md)

</div>

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Starters

### [Riverpod Basic Starter »](app_starters/riverpod_basic_starter/)

<p align="center">Copyable starter for <strong>Riverpod</strong>: GoRouter, l10n, feature folders, and a Material 3 seed theme.</p>

<div align="center">

[![Coverage](app_starters/riverpod_basic_starter/assets/coverage/badge.svg)](app_starters/riverpod_basic_starter/README.md#test-coverage)

[README »](app_starters/riverpod_basic_starter/README.md)

</div>

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

Git hooks and CI only after the folder is its **own** git repo. Copy `coverage_pipeline/` next to that repo's `pubspec.yaml`, copy [`coverage_pipeline/coverage.yml`](coverage_pipeline/coverage.yml) to `.github/workflows/coverage.yml`, and copy [`assets/badges/`](assets/badges/) into that repo's `assets/badges/`. Then:

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
