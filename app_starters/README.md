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
  <p>
     Copyable Flutter starters for new apps.
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
    <li><a href="#starters">Starters</a></li>
    <li><a href="#coverage-pipeline">Coverage pipeline</a></li>
  </ol>
</details>

---

## About

Copy a starter folder when you begin a new Flutter app.

[![iOS][ios]][ios-url]
[![Web][web]][web-url]

There is no Android project.

Coverage scripts live once in the playground [`coverage_pipeline/`](../coverage_pipeline/). Header badges live once in [`assets/badges/`](../assets/badges/). Each starter still owns its own coverage images.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Starters

### [Riverpod Basic Starter »](riverpod_basic_starter/)

<p align="center">Copyable starter for <strong>Riverpod</strong>: GoRouter, l10n, feature folders, and a Material 3 seed theme.</p>

<div align="center">

[![Coverage](riverpod_basic_starter/assets/coverage/badge.svg)](riverpod_basic_starter/README.md#test-coverage)

[README »](riverpod_basic_starter/README.md)

</div>

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Coverage pipeline

The badge on GitHub must match the code in that commit.

Scripts live once in the playground [`coverage_pipeline/`](../coverage_pipeline/). Each starter still owns `assets/coverage/` and the percent in its README.

1. Tests run with coverage.
2. `lcov.info` becomes `assets/coverage/badge.svg` (header) and `assets/coverage/card.svg` (README card).
3. `pre-commit` puts those images in the **same** commit.
4. `pre-push` blocks a failing push.
5. After the starter is its own repo, [coverage.yml](../coverage_pipeline/coverage.yml) fails CI if the committed images are stale.

Refresh this starter's badge from the playground root:

```
./coverage_pipeline/update_coverage.sh app_starters/riverpod_basic_starter
```

After you copy a starter into its **own** git repo, also copy `coverage_pipeline/` next to `pubspec.yaml`, copy [`coverage.yml`](../coverage_pipeline/coverage.yml) to `.github/workflows/coverage.yml`, and copy [`assets/badges/`](../assets/badges/) into that repo's `assets/badges/`. Then:

```
./coverage_pipeline/install-git-hooks.sh
```

<p align="right"><a href="#readme-top">back to top</a></p>

---

[dart]: ../assets/badges/dart.svg
[dart-url]: https://dart.dev/
[flutter]: ../assets/badges/flutter.svg
[flutter-url]: https://flutter.dev/
[flutter-localizations]: ../assets/badges/flutter_localizations.svg
[flutter-localizations-url]: https://docs.flutter.dev/ui/internationalization
[fvm]: ../assets/badges/fvm.svg
[fvm-url]: https://fvm.app
[gorouter]: ../assets/badges/gorouter.svg
[gorouter-url]: https://pub.dev/packages/go_router
[instagram-shield]: ../assets/badges/instagram.svg
[instagram-url]: https://www.instagram.com/codeincouture/
[intl]: ../assets/badges/intl.svg
[intl-url]: https://pub.dev/packages/intl
[ios]: ../assets/badges/ios.svg
[ios-url]: https://developer.apple.com/ios/
[linkedin-shield]: ../assets/badges/linkedin.svg
[linkedin-url]: https://www.linkedin.com/in/tanja-polz-5636401a5/
[riverpod]: ../assets/badges/riverpod.svg
[riverpod-url]: https://pub.dev/packages/flutter_riverpod
[very-good]: ../assets/badges/very_good.svg
[very-good-url]: https://pub.dev/packages/very_good_analysis
[web]: ../assets/badges/web.svg
[web-url]: https://docs.flutter.dev/platform-integration/web
[x-shield]: ../assets/badges/x.svg
[x-url]: https://twitter.com/_foxnoir_?lang=de
