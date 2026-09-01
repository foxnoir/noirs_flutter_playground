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
  <h1 align="center">Advanced Concepts</h1>
  <p>
     Practice project for navigation, layout, lists, and API integration: go, push, pop, replace; Flexible vs Expanded, PreferredSize, LayoutBuilder vs MediaQuery; ListView / GridView / slivers; unified API class, timeouts, and network errors.
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
[![Very Good Analysis](../assets/badges/very_good.svg)](https://pub.dev/packages/very_good_analysis)
[![FVM](../assets/badges/fvm.svg)](https://fvm.app)
[![iOS](../assets/badges/ios.svg)](https://developer.apple.com/ios/)
[![Web](../assets/badges/web.svg)](https://docs.flutter.dev/platform-integration/web)
[![Firebase](../assets/badges/firebase.svg)](https://firebase.google.com/)

</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about">About</a></li>
    <li>
      <a href="#gorouter">GoRouter</a>
      <ul>
        <li><a href="#go-vs-push">go vs push</a></li>
        <li><a href="#pop-vs-replace">pop vs replace</a></li>
        <li><a href="#named-vs-path">Named vs path</a></li>
        <li><a href="#buildcontext">BuildContext</a></li>
      </ul>
    </li>
    <li>
      <a href="#layout">Layout</a>
      <ul>
        <li><a href="#flexible-vs-expanded">Flexible vs Expanded</a></li>
        <li><a href="#preferredsize">PreferredSize</a></li>
        <li><a href="#layoutbuilder-vs-mediaquery">LayoutBuilder vs MediaQuery</a></li>
        <li><a href="#breakpoints">Breakpoints</a></li>
      </ul>
    </li>
    <li>
      <a href="#lists">Lists</a>
      <ul>
        <li><a href="#listview-vs-gridview-vs-slivers">ListView vs GridView vs slivers</a></li>
        <li><a href="#when-to-use-which">When to use which</a></li>
        <li><a href="#problems">Problems</a></li>
      </ul>
    </li>
    <li>
      <a href="#api-integration">API integration</a>
      <ul>
        <li><a href="#unified-api-class">Unified API class</a></li>
        <li><a href="#timeouts">Timeouts</a></li>
        <li><a href="#network-errors">Network errors</a></li>
      </ul>
    </li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li>
      <a href="#testing">Testing</a>
      <ul>
        <li><a href="#test-coverage">Test coverage</a></li>
      </ul>
    </li>
    <li><a href="#changelog">Changelog</a></li>
    <li><a href="#sources">Sources</a></li>
  </ol>
</details>

---

## About

This project is the **navigation**, **layout**, **lists**, and **API integration** practice project in [Noir's Flutter Playground](../README.md).

The **Landing Screen** is a list of labs. **Navigation** opens the Routing Lab (`RoutingLabScreen`; AppBar **Navigation**). **Layout** opens the Layout Lab (`LayoutLabScreen`): **Flexible** vs **Expanded**, **PreferredSize**, **LayoutBuilder** vs **MediaQuery**, and **Breakpoints**. **Lists** opens the Lists Lab (`ListsLabScreen`): ListView, GridView, and slivers, plus eager vs lazy build counts and the usual layout traps. **API HTTP** opens the API Integration Lab (`ApiIntegrationLabScreen`): one **ApiClient** (`package:http`) against a **Firebase** Cloud Functions + Firestore backend of romantasy **books**. **API Dio** opens an empty `ApiIntegrationDioLabScreen` (no data/domain yet). The Routing Lab has short rules for **go**, **push**, **pop**, **replace**, **Named**, and **BuildContext**, then the exact Dart calls to **User List**. A banner prints the call after the tap (under the AppBar). User List draws the **stack** (that frame is still **Routing Lab**), offers **pop** (no-op after **go**), and `pushNamed`s every row into **User Details**. **Go to Landing Screen** always `goNamed('landing')`, so `go` never traps you.

Screens are `LandingScreen`, `RoutingLabScreen`, `LayoutLabScreen`, `ListsLabScreen`, `ApiIntegrationLabScreen`, `ApiIntegrationDioLabScreen`, `UserListScreen`, `UserDetailsScreen`, `NotFoundScreen`. User List data is `InMemoryUserListDataSource` → `InMemoryUserListRepository`. Books go Firebase emulator → `package:http` → `ApiClient` → `HttpBookApiDataSource` → `HttpBookApiRepository`. Layers match [Riverpod Basics](../README.md#app-architecture-and-folder-structure).

[![iOS](../assets/badges/ios.svg)](https://developer.apple.com/ios/)
[![Web](../assets/badges/web.svg)](https://docs.flutter.dev/platform-integration/web)

There is no Android project. Run on the iOS Simulator (**iPhone 17 Pro**, iOS 26.5) or Chrome. Layout is **mobile first** everywhere: compact is the default, then `AppBreakpoint.mediumMin` (600). Do not branch on `kIsWeb`. There is no AdaptiveScaffold — breakpoints are the `AppBreakpoint` enum.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## GoRouter

**GoRouter** is Navigator 2.0: URLs, route names, one `GoRouter` in a Riverpod `Provider` (`lib/core/router/app_router.dart`). The tiles call those APIs so the stack is visible.

| | Path `'/user-list'` | Name `'userList'` |
| --- | --- | --- |
| Wipe the stack | `go` | `goNamed` |
| Stack on top | `push` | `pushNamed` |
| Swap this screen | `replace` | `replaceNamed` |
| Back one screen | `pop` | `pop` |

<p align="right"><a href="#readme-top">back to top</a></p>

### go vs push

Need **Back**? Use **push** (prefer **pushNamed** in app code). Switching the whole screen with no return? Use **go**.

| Call | Stack | Back on User List |
| --- | --- | --- |
| `context.go('/user-list')` | Replaces the location. Routing Lab is gone. | `canPop()` is false. AppBar Back does nothing. **Go to Landing Screen** still `goNamed('landing')`. |
| `context.push('/user-list')` | User List on top of Routing Lab. | `canPop()` is true. AppBar Back pops to Routing Lab. |

User List and User Details draw the stack under the AppBar.

<p align="right"><a href="#readme-top">back to top</a></p>

### pop vs replace

**pop** is Back. It only works when `canPop()` is true — something was **push**ed, or **replace**d so a screen is still on the stack below. After **go**, the stack is empty: `pop` does nothing (`canPop() is false`). Same as tapping AppBar Back.

**replace** / **replaceNamed** swaps the current screen. You do not see what was below, but it is still on the stack. From Routing Lab, `replaceNamed('userList')` drops Routing Lab; Landing Screen is underneath — Back from User List goes to Landing Screen, not Routing Lab.

Use **replace** when this screen should not come back: login → home, wizard step. Wrong for List → Details — that needs **push** so Back returns to the list.

| Call | Stack | Back on User List |
| --- | --- | --- |
| `context.pop()` after **push** | Drops User List. Routing Lab is visible again. | — |
| `context.pop()` after **go** | Nothing happens. Banner: `canPop() is false`. | AppBar Back does nothing. |
| `context.replaceNamed('userList')` | Routing Lab is gone from the screen. Landing Screen is still on the stack. | `canPop()` is true — Back goes to Landing Screen. |

<p align="right"><a href="#readme-top">back to top</a></p>

### Named vs path

**Named** finds the route by name. **go** / **push** use the path.

| Call | You pass | Why |
| --- | --- | --- |
| `goNamed('userList')` / `pushNamed('userList')` | [AppRouteNames](lib/core/router/app_router_names.dart) | Prefer this in app code. Renaming a path does not break callers. |
| `go('/user-list')` / `push('/user-list')` | The URL | What the browser / deep link uses. |

User Details is `/user-list/:userId` (child of User List). The list always `pushNamed`s so Back returns to the list.

User List is a **sibling** of Landing Screen, not a nested child of Routing Lab. Nested under `/routing`, `go('/user-list')` would keep Routing Lab as a parent and the go vs push demo would vanish.

<p align="right"><a href="#readme-top">back to top</a></p>

### BuildContext

**context.go** is **GoRouter.of(context).go** — same router, via **BuildContext**. Same for `goNamed`, `push`, `pushNamed`.

A **Notifier** has no context. Read **goRouterProvider** instead:

```dart
ref.read(goRouterProvider).go('/user-list');
ref.read(goRouterProvider).pushNamed('userList');
```

| On a widget | On the router |
| --- | --- |
| `context.go(path)` | `router.go(path)` |
| `context.goNamed(name)` | `router.goNamed(name)` |
| `context.push(path)` | `router.push(path)` |
| `context.pushNamed(name)` | `router.pushNamed(name)` |

`router` is `GoRouter.of(context)` or `ref.read(goRouterProvider)`. **`.go` still replaces**, **`.pushNamed` still pushes**.

Do not pass `BuildContext` into a notifier or repository.

The lab shows **go**, **push**, **pop**, and **replace** on `context`, plus **go** and **pushNamed** on the provider.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Layout

**Flexible**, **Expanded**, **PreferredSize**, **LayoutBuilder**, and **MediaQuery** are about *constraints*, not scrolling. A `Row` / `Column` splits leftover space among flex children. `Scaffold.appBar` (and `bottomNavigationBar`) does not: it asks the widget for a **preferred** height, then lays out `body` in what is left. **MediaQuery.sizeOf** is the app **window**. **LayoutBuilder** is the **parent**. **AppBreakpoint** maps that width to compact / medium / expanded / large / extra-large. Compact is the default (mobile first).

The Layout Lab (`lib/features/layout_lab/`) is a short rule list and live pictures, in that order: **Flexible vs Expanded** (leftover labeled), **PreferredSize** (AppBar 56 vs custom 96 stacked), **LayoutBuilder vs MediaQuery** (120-wide parent: overflow stripes vs a child that fits), **Breakpoints** (compact Column, Row from 600), then **wrong vs works** Row overflow (yellow-black stripes vs `Expanded`). AppBar is **Layout**. Breakpoints live in `lib/core/theme/app_breakpoint.dart` (Material 3 compact / medium / expanded / large / extra-large). Not AdaptiveScaffold. Lab screens cap copy at 840 (`LabScreenBody`) so a wide Chrome window does not stretch the text. Mobile first is the default for every layout, not a separate trick.

### Flexible vs Expanded

Both work only as a child of a `Flex` (`Row`, `Column`, `Flex`). Both take a `flex` factor (default `1`). They differ in **fit**:

| | `fit` | Leftover space |
| --- | --- | --- |
| `Flexible` | `FlexFit.loose` | Child **may** be smaller. min constraint is `0`. Gray leftover in the lab. |
| `Expanded` | `FlexFit.tight` | Child **must** fill. min = max = leftover. |

`Expanded` is `Flexible(fit: FlexFit.tight)`. Same widget, tighter constraints.

The lab puts a short **Hi** between two fixed `64` boxes. With `Flexible`, **leftover** stays empty. With `Expanded`, **Hi** fills.

A child that *wants* to be as big as possible (`Center`, `Align`, `Container` with `alignment`) will fill leftover even inside `Flexible`. Use a child with an intrinsic size (`Text`, `ColoredBox` + `Text`) when you want the loose fit to show.

A vertical `ListView` in a `Column` needs a **max** height. That is why Lists wraps it in `Expanded` (see [Problems](#problems)): `Expanded` gives the list a bounded leftover. `Flexible` would let the list stay as small as its children — and a `ListView` tries to be infinitely tall, so that still explodes.

<p align="right"><a href="#readme-top">back to top</a></p>

### PreferredSize

`Scaffold.appBar` and `bottomNavigationBar` take a `PreferredSizeWidget`. They read `preferredSize` and reserve that height. They do **not** pass flex constraints.

`AppBar` already implements `PreferredSizeWidget`. Default toolbar height is `kToolbarHeight` (`56`). If `primary` is true (the normal full-screen AppBar), Scaffold also adds status-bar padding.

Any widget can sit in that slot if you wrap it:

```dart
appBar: PreferredSize(
  preferredSize: Size.fromHeight(96),
  child: /* not necessarily an AppBar */,
),
```

`preferredSize` is a **hint** to the parent. If the child is shorter, you get empty space in the bar. If the child is taller, it overflows. The lab’s nested Scaffold switches **AppBar** (`56` when `primary: false`) and **PreferredSize 96** so the body shrinks as the bar grows.

Do not use `PreferredSize` as a `Row` / `Column` child to “give a size”. That is `SizedBox` / `Flexible` / `Expanded`.

<p align="right"><a href="#readme-top">back to top</a></p>

### LayoutBuilder vs MediaQuery

They answer different questions. Use the one that matches the question.

| | Reads | Use when |
| --- | --- | --- |
| `MediaQuery.sizeOf(context)` | The **window** | App-level chrome: how wide is this Flutter view? Prefer `sizeOf` over `MediaQuery.of(context).size` so unrelated MediaQuery fields do not rebuild you. |
| `LayoutBuilder` | The **parent** | A widget that might sit in a pane, a sidebar, or a capped body. `constraints.maxWidth` is the space you actually got. |

A 120-wide parent inside a 400-wide phone still has **120** pixels. `LayoutBuilder` says so. `MediaQuery.sizeOf` still says **400**. If the child uses that 400 as its width, it overflows — yellow-black stripes, even on a phone.

Do **not** switch layouts with `kIsWeb`, `Platform.isIOS`, or `OrientationBuilder` at the app root. Chrome can be phone-sized. A phone can be landscape. Layout from **width**.

The lab’s **wrong** box paints the same yellow-black overflow as Row overflow. The **works** box is a 120-wide child. No need to resize Chrome.

<p align="right"><a href="#readme-top">back to top</a></p>

### Breakpoints

There is no `AdaptiveScaffold` here. Breakpoints are **numbers** in `AppBreakpoint` (`lib/core/theme/app_breakpoint.dart`): **600**, **840**, **1200**, **1600**. `fromWidth` maps a width onto compact / medium / expanded / large / extra-large. **Nothing jumps by itself.** `MediaQuery.sizeOf` only reports the window. A widget jumps when it compares: this lab’s tiles use the **parent** (`LayoutBuilder`) and switch Column → Row at **600** (`isCompact`).

`LabScreenBody` caps the parent at 840. On a wide Chrome window the **window** marker can sit in large while the **parent** marker stops near 840 — that is why the two lines can disagree.

```dart
if (AppBreakpoint.fromWidth(parentWidth).isCompact) {
  return Column(children: [a, b]);
}
return Row(children: [Expanded(child: a), Expanded(child: b)]);
```

On iPhone 17 Pro both markers sit in compact and the tiles stack. Widen Chrome past 600: parent crosses 600, tiles go to a row. Keep widening: window keeps moving, parent stops at the 840 cap.

Path URLs (`usePathUrlStrategy`) so Chrome shows `/layout`, not `/#/layout`.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Lists

**ListView**, **GridView**, and **slivers** all paint children in a scrollable. They differ in *shape*, *laziness*, and whether they *own* the scroll or *join* one.

The Lists Lab (`lib/features/lists_lab/`) is a short rule list, a live preview (48 cells, **cells** vs **builds**), and three problem pictures. AppBar is **Lists**.

### ListView vs GridView vs slivers

| | Builds children | Scroll | Shape |
| --- | --- | --- | --- |
| `ListView(children: …)` | All, immediately | Own box | One column (or row if `scrollDirection: Axis.horizontal`) |
| `ListView.builder` | Viewport + cache | Own box | Same |
| `GridView.builder` | Viewport + cache | Own box | Fixed cross-axis count / extent |
| `CustomScrollView` + **slivers** | Per sliver, lazy if you use a builder delegate | **One** scrollbar | Mix: header, grid, list, `SliverAppBar`, … |

A **sliver** is not a widget you drop in a `Column`. It is a slice of a `CustomScrollView` (or another sliver viewport). `SliverList` / `SliverGrid` / `SliverToBoxAdapter` are the usual three. `ListView` is a box that *contains* a sliver list. `GridView` is a box that contains a sliver grid. Same engine, different API.

`.builder` (and `SliverChildBuilderDelegate`) constructs a child when it is about to appear. `ListView(children: [ … ])` and `SliverChildListDelegate` construct the whole list in `build`.

<p align="right"><a href="#readme-top">back to top</a></p>

### When to use which

| You need | Use |
| --- | --- |
| A long feed, chat, settings — one column | `ListView.builder` |
| A carousel, chips, stories — one row | `ListView.builder(scrollDirection: Axis.horizontal)` |
| A gallery of same-size tiles | `GridView.builder` (`SliverGridDelegateWithFixedCrossAxisCount` or `…MaxCrossAxisExtent`) |
| A short, known set (~10 tiles, no jump-to-index) | `ListView(children: …)` is fine |
| Header **and** grid **and** list, **one** finger-scroll | `CustomScrollView` with slivers — not a `Column` of three scrollables |
| A bar that pins while the rest moves | `SliverAppBar` (pinned / floating) inside that `CustomScrollView` |

Do not reach for slivers because they sound advanced. Reach for them when **one** scroll must stitch different layouts.

<p align="right"><a href="#readme-top">back to top</a></p>

### Problems

**Eager `children:`** Every child runs `initState` before the first frame. Fine for a handful. On hundreds you pay layout, images, and memory up front. The lab’s left mini-list uses `ListView(children:)` and shows **cells 24 / 24**. The right mini-list is `.builder` and stays near the viewport plus cache.

**Dispose on scroll.** `.builder` does not keep off-screen `State`. Scroll a cell away, then back: `initState` runs again. The lab splits **cells** (unique indices, never above 48) from **builds** (`initState` count). Scroll to the end and back: cells stay at 48, builds climb. That is not extra items — same tiles, new `State`. `AutomaticKeepAliveClientMixin` would keep them; the default does not.

**Unbounded height.** A `ListView` in the *vertical* axis wants a **max** height. A `Column` gives children unbounded max height. `Column` → `ListView` throws *Vertical viewport was given unbounded height.* The lab does **not** crash the page: the **wrong** box paints Flutter’s yellow-black stripes and that assertion. The **works** box is a live `Column` + `Expanded` + `ListView` — scroll it. Same header, different constraints. Same trap sideways: a horizontal `ListView` in a `Row` without `Expanded` or a width. Same trap: `ListView` inside another vertical `ListView` without `shrinkWrap`.

**`shrinkWrap: true`.** The list measures all children to pick its own height, then sits in a parent scroll. Nested scrollables often “need” this. It is the eager-layout tax again. Prefer one `CustomScrollView`.

The lab draws the Column trap as **wrong** (stripes + assertion) vs **works** (a list you can scroll). It does not crash the screen on purpose.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## API integration

**ApiClient** (`lib/core/network/api_client.dart`) is the unified API class: `package:http`, then `.timeout`, then status codes, then connection errors. It throws `AppException`. The book data source only parses JSON. The repository maps to `AppFailure`.

The backend lives in `backend/`: **Cloud Functions** (HTTP) + **Firestore** (books). Same functions as a typical Dio training server: `GET /success`, `GET /error`, `GET /timeout` (2s delay), `POST /identify`, `GET /books`, plus `PUT` / `DELETE` on `/books/:id`. Content is romantasy (Maas, Yarros, *Liebe kennt keine Grenzen*).

This is real HTTP. The emulator is a local Firebase, not an in-process fake. Tests inject `http.MockClient` so CI does not need Java.

<p align="right"><a href="#readme-top">back to top</a></p>

### Unified API class

Wrong: `if (response.statusCode == 200)` in every data-source method. Timeout never happens. Error strings leak into data.

Works: `ApiClient.get('/books', parse)`. `GET /success` and `GET /books` share the mapping. JSON stays wrapped (`data`, `books`) so parsing is deliberate.

<p align="right"><a href="#readme-top">back to top</a></p>

### Timeouts

Wrong: `send(request)` with no deadline. `GET /timeout` on the emulator waits 2s; the button spins until it returns.

Works: `send(request).timeout(...)`. The client fails first with `RequestTimeoutException` → `TimeoutFailure` → `ErrorWidget`.

<p align="right"><a href="#readme-top">back to top</a></p>

### Network errors

Wrong: `catch (e) => Text(e.toString())`. 401 and 500 look the same.

Works: `401` → `UnauthorizedException`, `500` → `ServerException`, thrown connection → `NetworkException`. Each has a localized line. `POST /identify` with the wrong author is the 401 drill.

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
cd advanced_concepts
fvm install
fvm flutter pub get
```

API lab: start the Firebase emulator **first**, leave that Terminal open, then run Flutter in a second Terminal.

```
cd backend
./start.sh
```

Wait for `All emulators ready`. API: `http://127.0.0.1:5001/noirs-firebase-lab/europe-west1/api`. UI: `http://127.0.0.1:4000`.

```
fvm flutter run
```

`fvm flutter run` uses the **iOS Simulator** (**iPhone 17 Pro**, iOS 26.5) — mobile first. For web:

```
fvm flutter run -d chrome
```

Chrome shows path URLs (`/layout`, `/api-http`, `/api-dio`). There is no Android project. A static host needs a rewrite to `index.html` for those paths; `flutter run` already does.

This project is pinned with [FVM](https://fvm.app). After `fvm install`, Cursor uses the SDK at `.fvm/flutter_sdk`.

Packages live in `pubspec.yaml` (do not copy versions from this README; they move). Runtime: `flutter_riverpod`, `go_router`, `http`, `intl`, `cupertino_icons`, `flutter_web_plugins`. Dev: `riverpod_lint`, `very_good_analysis`. Optional cloud deploy: `cd backend && ./deploy.sh` (Google login + Blaze).

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Testing

`test/` mirrors `lib/`. Provider tests fake the **repository**. Widget tests wrap `ProviderScope`. The landing test opens **Navigation**, then checks that `pushNamed` keeps Routing Lab on the stack and `goNamed` does not, and that **Go to Landing Screen** still returns to the hub. **Layout** opens Flexible vs Expanded, PreferredSize, LayoutBuilder vs MediaQuery (MediaQuery child overflows a 120 parent; LayoutBuilder child fits), and Breakpoints (compact stacks). **Lists** opens the Lists Lab preview (ListView / GridView / Sliver). **API HTTP** opens the API Integration Lab (`package:http` against a mock in tests; Firebase emulator when you run the app). **API Dio** opens the empty `ApiIntegrationDioLabScreen`.

<p align="right"><a href="#readme-top">back to top</a></p>

### Test coverage

<!-- coverage-percent:start -->
**85.0%** line coverage (1685 of 1983 lines).
<!-- coverage-percent:end -->

![Coverage](assets/coverage/card.svg)

The card and the header badge are regenerated on **playground commit** (git hooks at the repo root) when tests pass. A failing test does not block the commit; **push** still requires green tests (`pre-push`). GitHub Actions runs tests on Linux and does **not** commit the SVGs. `fvm flutter test --coverage` only writes local `lcov.info` for **Coverage Gutters**, and only for files the tests loaded. Unused `lib/` files are added as 0 hits when the playground generator runs. Saving a Dart file does not update the SVGs by itself.

```
cd advanced_concepts
fvm flutter test --coverage
```

Or run the VS Code task **Flutter: Test with coverage**, then Command Palette → **Coverage Gutters: Display Coverage**.

How the badges are produced: playground [coverage pipeline](../README.md#coverage-pipeline).

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Changelog

Changes to this playground: [noirs_flutter_playground](https://github.com/foxnoir/noirs_flutter_playground).

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Sources

- [go_router](https://pub.dev/packages/go_router)
- [Flexible](https://api.flutter.dev/flutter/widgets/Flexible-class.html)
- [Expanded](https://api.flutter.dev/flutter/widgets/Expanded-class.html)
- [PreferredSize](https://api.flutter.dev/flutter/widgets/PreferredSize-class.html)
- [LayoutBuilder](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html)
- [MediaQuery.sizeOf](https://api.flutter.dev/flutter/widgets/MediaQuery/sizeOf.html)
- [Adaptive and responsive design](https://docs.flutter.dev/ui/adaptive-responsive)
- [Material 3 breakpoints](https://m3.material.io/foundations/layout/breakpoints/overview)
- [Flutter web](https://docs.flutter.dev/platform-integration/web)
- [ListView](https://api.flutter.dev/flutter/widgets/ListView-class.html)
- [GridView](https://api.flutter.dev/flutter/widgets/GridView-class.html)
- [Sliver overview](https://docs.flutter.dev/ui/layout/scrolling/slivers)
- [Future.timeout](https://api.flutter.dev/flutter/dart-async/Future/timeout.html)
- [http](https://pub.dev/packages/http)
- [Cloud Functions HTTP](https://firebase.google.com/docs/functions/http-events)
- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
- [riverpod_lint](https://pub.dev/packages/riverpod_lint)
- [very_good_analysis](https://pub.dev/packages/very_good_analysis)

<p align="right"><a href="#readme-top">back to top</a></p>
