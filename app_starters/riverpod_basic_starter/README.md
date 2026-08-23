<a name="readme-top"></a>

<!-- Top Links Bar -->

[![LinkedIn][linkedin-shield]][linkedin-url]
[![X][x-shield]][x-url]
[![Instagram][instagram-shield]][instagram-url]
[![Coverage][coverage-shield]](#test-coverage)
[![iOS][ios]][ios-url]
[![Web][web]][web-url]

<!-- PROJECT LOGO -->
<br />

<div align="center">
  <img src="images/logo.png" alt="Logo" width="80" height="80">
  <h1 align="center">Riverpod Basic Starter</h1>

  <p align="left">
     Starter for Riverpod — copy this app when you begin a new project. **iOS + Web** (no Android).
  </p>
  
  <p align="left">
    <a href="lib/"><strong>Explore the project »</strong></a>
    ·
    <a href="../../README.md"><strong>Back to playground »</strong></a>
    <br/>
  </p>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-this-project">About this project</a></li>
    <li><a href="#features">Features</a></li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#test-coverage">Test coverage</a></li>
        <li><a href="#coverage-pipeline">Coverage pipeline</a></li>
      </ul>
    </li>
  </ol>
</details>

---

## About this project

This is a **Riverpod** starter in [Noir's Flutter Playground](../../README.md). Copy the folder and rename the Dart package.

**iOS + Web** — there is no Android project. Run on the iOS Simulator or Chrome.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Features

- **iOS + Web** (no Android)
- [Riverpod][riverpod-url] (`ProviderScope`)
- [GoRouter](https://pub.dev/packages/go_router)
- l10n (English / German)
- Feature folders (`presentation` / `data` / `domain`)
- Material 3 seed theme
- [FVM](https://fvm.app) pin
- Coverage pipeline (badge, card, git hooks)

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
**66.3%** line coverage (65 of 98 lines).
<!-- coverage-percent:end -->

![Coverage](images/coverage.svg)

The card and the header badge are regenerated on every commit and committed with the same snapshot as the code. Raw `lcov.info` stays local for **Coverage Gutters**.

```
cd app_starters/riverpod_basic_starter
fvm flutter test --coverage
```

Or run the VS Code task **Flutter: Test with coverage**, then Command Palette → **Coverage Gutters: Display Coverage**.

### Coverage pipeline

The badge on GitHub must match the code in that commit.

1. Tests run with coverage (`fvm flutter test --coverage`).
2. `lcov.info` is turned into two images: the small header **badge** and the README **card**, plus the percent in this file.
3. `pre-commit` stages those files so they ride in the **same** commit.
4. `pre-push` runs the tests again and blocks a failing push.
5. GitHub Actions repeats the generation and fails if the committed images are stale.

`coverage/lcov.info` stays gitignored for Coverage Gutters. The SVGs and the README percent are committed.

In this playground the **root** pipeline ([`../../tool/`](../../tool/)) already does this for every app. You do not install the local hooks here.

After you copy this folder into its **own** git repo, the copy in [`tool/`](tool/) takes over:

- [`install-git-hooks.sh`](tool/install-git-hooks.sh) — link `pre-commit` and `pre-push` (inside this playground the script exits on purpose)
- [`update_coverage.sh`](tool/update_coverage.sh) — tests + image generation
- [`coverage_badge.py`](tool/coverage_badge.py) — SVG badge and card from `lcov.info`
- [`git-hooks/pre-commit`](tool/git-hooks/pre-commit) / [`pre-push`](tool/git-hooks/pre-push)
- [`.github/workflows/coverage.yml`](.github/workflows/coverage.yml) — CI check

```
./tool/install-git-hooks.sh
```

<p align="right"><a href="#readme-top">back to top</a></p>

---

[coverage-shield]: images/coverage_badge.svg
[dart]: https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white
[dart-url]: https://dart.dev/
[flutter]: https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white
[flutter-url]: https://flutter.dev/
[instagram-shield]: https://img.shields.io/badge/Instagram-%23E4405F.svg?style=for-the-badge&logo=instagram&logoColor=white
[instagram-url]: https://www.instagram.com/codeincouture/
[ios]: https://img.shields.io/badge/iOS-000000.svg?style=for-the-badge&logo=apple&logoColor=white
[ios-url]: https://developer.apple.com/ios/
[web]: https://img.shields.io/badge/Web-02569B.svg?style=for-the-badge&logo=googlechrome&logoColor=white
[web-url]: https://docs.flutter.dev/platform-integration/web
[linkedin-shield]: https://img.shields.io/badge/LinkedIn-%230A66C2.svg?style=for-the-badge&logo=linkedin&logoColor=white
[linkedin-url]: https://www.linkedin.com/in/tanja-polz-5636401a5/
[riverpod]: https://img.shields.io/badge/Riverpod-0468D7.svg?style=for-the-badge&logo=riverpod&logoColor=white
[riverpod-url]: https://pub.dev/packages/flutter_riverpod
[x-shield]: https://img.shields.io/badge/-%23000000.svg?style=for-the-badge&logo=x&logoColor=white
[x-url]: https://twitter.com/_foxnoir_?lang=de
