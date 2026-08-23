<a name="readme-top"></a>

<!-- Top Links Bar -->

[![LinkedIn][linkedin-shield]][linkedin-url]
[![X][x-shield]][x-url]
[![Instagram][instagram-shield]][instagram-url]

<!-- PROJECT LOGO -->
<br />

<div align="center">
  <img src="../images/logo.png" alt="Logo" width="80" height="80">
  <h1 align="center">App Starters</h1>

  <p align="left">
     Copyable Flutter starters for new apps. **iOS + Web** (no Android).
  </p>
  <p align="left">
    [![iOS][ios]][ios-url]
    [![Web][web]][web-url]
  </p>
  
  <p align="left">
    <a href="riverpod_basic_starter/"><strong>Riverpod Basic Starter »</strong></a>
    ·
    <a href="../README.md"><strong>Back to playground »</strong></a>
    <br/>
  </p>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about">About</a>
      <ul>
        <li><a href="#starters">Starters</a></li>
      </ul>
    </li>
    <li><a href="#coverage-pipeline">Coverage pipeline</a></li>
  </ol>
</details>

---

## About

Copy a starter folder when you begin a new Flutter app.

Starters target **iOS** and **Web**. There is no Android project.

Each starter ships the **coverage pipeline**: badge, card, and git hooks so GitHub never shows a stale percent.

<p align="right"><a href="#readme-top">back to top</a></p>

### Starters

#### [Riverpod Basic Starter](riverpod_basic_starter/)

Starter for **Riverpod**. **iOS + Web.**

[![Coverage](riverpod_basic_starter/images/coverage_badge.svg)](riverpod_basic_starter/README.md#test-coverage)

More detail: [riverpod_basic_starter/README.md](riverpod_basic_starter/README.md)

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Coverage pipeline

The badge on GitHub must match the code in that commit.

While a starter still lives in this playground, the **root** pipeline in [`../tool/`](../tool/) runs tests, builds the badge and card, and stages them on commit.

Each starter also carries its own `tool/` copy for after you move the folder into a new git repo:

1. Tests run with coverage.
2. `lcov.info` becomes `images/coverage_badge.svg` (header) and `images/coverage.svg` (README card).
3. `pre-commit` puts those images in the **same** commit.
4. `pre-push` blocks a failing push.
5. `.github/workflows/coverage.yml` fails CI if the committed images are stale.

```
./tool/install-git-hooks.sh
```

Run that from the **new** repo. Inside this playground the script exits and tells you the root hooks already cover starters.

<p align="right"><a href="#readme-top">back to top</a></p>

---

[instagram-shield]: https://img.shields.io/badge/Instagram-%23E4405F.svg?style=for-the-badge&logo=instagram&logoColor=white
[instagram-url]: https://www.instagram.com/codeincouture/
[ios]: https://img.shields.io/badge/iOS-000000.svg?style=for-the-badge&logo=apple&logoColor=white
[ios-url]: https://developer.apple.com/ios/
[web]: https://img.shields.io/badge/Web-02569B.svg?style=for-the-badge&logo=googlechrome&logoColor=white
[web-url]: https://docs.flutter.dev/platform-integration/web
[linkedin-shield]: https://img.shields.io/badge/LinkedIn-%230A66C2.svg?style=for-the-badge&logo=linkedin&logoColor=white
[linkedin-url]: https://www.linkedin.com/in/tanja-polz-5636401a5/
[x-shield]: https://img.shields.io/badge/-%23000000.svg?style=for-the-badge&logo=x&logoColor=white
[x-url]: https://twitter.com/_foxnoir_?lang=de
