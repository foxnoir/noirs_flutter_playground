<a name="readme-top"></a>

<!-- Top Links Bar -->

[![LinkedIn][linkedin-shield]][linkedin-url]
[![X][x-shield]][x-url]
[![Instagram][instagram-shield]][instagram-url]

<!-- PROJECT LOGO -->
<br />

<div align="center">
  <img src="../assets/logo.png" alt="Logo" width="80" height="80">
  <h1 align="center">App Starters</h1>

  <p align="left">
     Copyable Flutter starters for new apps.
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
    <li><a href="#starters">Starters</a></li>
    <li><a href="#coverage-pipeline">Coverage pipeline</a></li>
  </ol>
</details>

---

## About this project

Copy a starter folder when you begin a new Flutter app.

[![iOS][ios]][ios-url]
[![Web][web]][web-url]

There is no Android project.

Each starter ships its own **coverage pipeline** in `coverage_pipeline/`.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Starters

### Riverpod Basic Starter

Copyable starter for **Riverpod**: GoRouter, l10n, feature folders, and a Material 3 seed theme. **iOS + Web.**

[![Coverage](riverpod_basic_starter/assets/coverage/badge.svg)](riverpod_basic_starter/README.md#test-coverage)

<a href="riverpod_basic_starter/"><strong>Go to the project »</strong></a>
<br/>
<a href="riverpod_basic_starter/README.md"><strong>README »</strong></a>

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Coverage pipeline

The badge on GitHub must match the code in that commit.

Every starter has its own [`coverage_pipeline/`](riverpod_basic_starter/coverage_pipeline/) folder — not a playground-wide setup.

1. Tests run with coverage.
2. `lcov.info` becomes `assets/coverage/badge.svg` (header) and `assets/coverage/card.svg` (README card).
3. `pre-commit` puts those images in the **same** commit.
4. `pre-push` blocks a failing push.
5. `.github/workflows/coverage.yml` fails CI if the committed images are stale.

Refresh this starter's badge:

```
cd riverpod_basic_starter
./coverage_pipeline/update_coverage.sh
```

After you copy a starter into its **own** git repo:

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
