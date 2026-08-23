<a name="readme-top"></a>

<!-- Top Links Bar -->

[![LinkedIn][linkedin-shield]][linkedin-url]
[![X][x-shield]][x-url]
[![Instagram][instagram-shield]][instagram-url]

<!-- PROJECT LOGO -->
<br />

<div align="center">
  <img src="images/logo.png" alt="Logo" width="80" height="80">
  <h1 align="center">Noir's Flutter Playground</h1>

  <p align="left">
     Practice projects for Flutter — among other things Riverpod, architecture, and advanced topics. **iOS + Web** (no Android).
  </p>
  <p align="left">
    [![iOS][ios]][ios-url]
    [![Web][web]][web-url]
  </p>
  
  <h3 align="left">Previous Projects</h3>
  <p align="left">
    <a href="riverpod_basics/"><strong>Riverpod Basics »</strong></a>
    <br/>
    <a href="app_starters/riverpod_basic_starter/"><strong>Riverpod Basic Starter »</strong></a>
    <br/>
  </p>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about">About</a>
      <ul>
        <li><a href="#project-summaries">Project Summaries</a></li>
      </ul>
    </li>
    <li><a href="#coverage-pipeline">Coverage pipeline</a></li>
  </ol>
</details>

---

## About

This repository is a playground for practicing Flutter.

Each folder is a standalone Flutter app. Topics include **Riverpod**, architecture, and other advanced Flutter subjects — without mixing everything into one project.

Practice targets **iOS** and **Web**. There is no Android project.

Copyable starters live in [app_starters](app_starters/).

The root README stays short: a link and a rough summary per project. Getting started and the detailed notes live in the README of that project.

<p align="right"><a href="#readme-top">back to top</a></p>

### Project Summaries

#### [Riverpod Basics](riverpod_basics/)

Starter app for **Riverpod** fundamentals: providers, `ConsumerWidget`, and reactive UI. **iOS + Web.**

[![Coverage](riverpod_basics/images/coverage_badge.svg)](riverpod_basics/README.md#test-coverage)

More detail: [riverpod_basics/README.md](riverpod_basics/README.md)

#### [Riverpod Basic Starter](app_starters/riverpod_basic_starter/)

Starter for **Riverpod**: GoRouter, l10n, feature folders, and a Material 3 seed theme. **iOS + Web.**

[![Coverage](app_starters/riverpod_basic_starter/images/coverage_badge.svg)](app_starters/riverpod_basic_starter/README.md#test-coverage)

More detail: [app_starters/riverpod_basic_starter/README.md](app_starters/riverpod_basic_starter/README.md)

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Coverage pipeline

The badge on GitHub must match the code in that commit — not the previous one.

On every commit the pipeline:

1. Runs `flutter test --coverage` in each app.
2. Turns `lcov.info` into two images: the small header **badge** and the README **card**.
3. Writes the percent into the README.
4. Stages those files so they land in the **same** commit (`pre-commit`).
5. Runs the tests again on `git push` and blocks a failing push (`pre-push`).

GitHub Actions repeats the generation and fails if the committed images are stale.

Scripts live in [`tool/`](tool/):

- [`install-git-hooks.sh`](tool/install-git-hooks.sh) — after a clone, link `pre-commit` and `pre-push`
- [`update_coverage.sh`](tool/update_coverage.sh) — tests + image generation for every app
- [`coverage_badge.py`](tool/coverage_badge.py) — SVG badge and card from `lcov.info`
- [`flutter_apps.sh`](tool/flutter_apps.sh) — which folders count as apps (`riverpod_basics`, `app_starters/*`)
- [`git-hooks/pre-commit`](tool/git-hooks/pre-commit) / [`pre-push`](tool/git-hooks/pre-push)
- [`.github/workflows/coverage.yml`](.github/workflows/coverage.yml) — CI check

```
./tool/install-git-hooks.sh
```

Each starter also ships this pipeline in its own `tool/` folder, so it keeps working after you copy the app into a new repo.

<p align="right"><a href="#readme-top">back to top</a></p>

---

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
