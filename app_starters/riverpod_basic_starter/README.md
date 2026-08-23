<a name="readme-top"></a>

<!-- Top Links Bar -->

<a href="#test-coverage"><img align="right" src="assets/coverage/badge.svg" alt="Coverage"></a>

[![LinkedIn][linkedin-shield]][linkedin-url]
[![X][x-shield]][x-url]
[![Instagram][instagram-shield]][instagram-url]

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
    <li><a href="#about">About</a></li>
    <li><a href="#features">Features</a></li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#test-coverage">Test coverage</a></li>
      </ul>
    </li>
  </ol>
</details>

---

## About

This is a **Riverpod** starter in [Noir's Flutter Playground](../../README.md). Copy the folder and rename the Dart package.

[![iOS][ios]][ios-url]
[![Web][web]][web-url]

There is no Android project. Run on the iOS Simulator or Chrome.

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
**66.3%** line coverage (65 of 98 lines).
<!-- coverage-percent:end -->

![Coverage](assets/coverage/card.svg)

The card and the header badge are regenerated on every commit and committed with the same snapshot as the code. Raw `lcov.info` stays local for **Coverage Gutters**.

```
cd app_starters/riverpod_basic_starter
fvm flutter test --coverage
```

Or run the VS Code task **Flutter: Test with coverage**, then Command Palette → **Coverage Gutters: Display Coverage**.

The shared scripts live in the playground [coverage pipeline](../../README.md#coverage-pipeline).

<p align="right"><a href="#readme-top">back to top</a></p>

---

[dart]: ../../assets/badges/dart.svg
[dart-url]: https://dart.dev/
[flutter]: ../../assets/badges/flutter.svg
[flutter-url]: https://flutter.dev/
[flutter-localizations]: ../../assets/badges/flutter_localizations.svg
[flutter-localizations-url]: https://docs.flutter.dev/ui/internationalization
[fvm]: ../../assets/badges/fvm.svg
[fvm-url]: https://fvm.app
[gorouter]: ../../assets/badges/gorouter.svg
[gorouter-url]: https://pub.dev/packages/go_router
[instagram-shield]: ../../assets/badges/instagram.svg
[instagram-url]: https://www.instagram.com/codeincouture/
[intl]: ../../assets/badges/intl.svg
[intl-url]: https://pub.dev/packages/intl
[ios]: ../../assets/badges/ios.svg
[ios-url]: https://developer.apple.com/ios/
[linkedin-shield]: ../../assets/badges/linkedin.svg
[linkedin-url]: https://www.linkedin.com/in/tanja-polz-5636401a5/
[riverpod]: ../../assets/badges/riverpod.svg
[riverpod-url]: https://pub.dev/packages/flutter_riverpod
[very-good]: ../../assets/badges/very_good.svg
[very-good-url]: https://pub.dev/packages/very_good_analysis
[web]: ../../assets/badges/web.svg
[web-url]: https://docs.flutter.dev/platform-integration/web
[x-shield]: ../../assets/badges/x.svg
[x-url]: https://twitter.com/_foxnoir_?lang=de
