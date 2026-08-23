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

  <p align="left">
     Practice projects for Flutter — among other things Riverpod, architecture, and advanced topics.
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

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-this-project">About this project</a></li>
    <li><a href="#previous-projects">Previous Projects</a></li>
    <li><a href="#starters">Starters</a></li>
    <li><a href="#coverage-pipeline">Coverage pipeline</a></li>
  </ol>
</details>

---

## About this project

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

### Riverpod Basics

Practice app for **Riverpod** fundamentals: providers, `ConsumerWidget`, and reactive UI. **iOS + Web.**

[![Coverage](riverpod_basics/assets/coverage/badge.svg)](riverpod_basics/README.md#test-coverage)

<a href="riverpod_basics/"><strong>Go to the project »</strong></a>
<br/>
<a href="riverpod_basics/README.md"><strong>README »</strong></a>

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Starters

### Riverpod Basic Starter

Copyable starter for **Riverpod**: GoRouter, l10n, feature folders, and a Material 3 seed theme. **iOS + Web.**

[![Coverage](app_starters/riverpod_basic_starter/assets/coverage/badge.svg)](app_starters/riverpod_basic_starter/README.md#test-coverage)

<a href="app_starters/riverpod_basic_starter/"><strong>Go to the project »</strong></a>
<br/>
<a href="app_starters/riverpod_basic_starter/README.md"><strong>README »</strong></a>

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Coverage pipeline

Each app owns its own coverage — not the playground root. Practice apps and starters both ship a [`coverage_pipeline/`](riverpod_basics/coverage_pipeline/) folder.

On commit the pipeline:

1. Runs `flutter test --coverage` in **that** app.
2. Turns `lcov.info` into two images: `assets/coverage/badge.svg` (header) and `assets/coverage/card.svg` (README card).
3. Writes the percent into that app's README.
4. Stages those files so they land in the **same** commit (`pre-commit`).
5. Runs the tests again on `git push` and blocks a failing push (`pre-push`).

Refresh one app:

```
cd riverpod_basics
./coverage_pipeline/update_coverage.sh
```

Git hooks only after the folder is its **own** git repo:

```
./coverage_pipeline/install-git-hooks.sh
```

<p align="right"><a href="#readme-top">back to top</a></p>

---

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
