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
  <h1 align="center">Riverpod Basics</h1>
  <p>
     Practice project for Riverpod: providers, labs (listen, ConsumerWidget, refresh / invalidate), and Freezed.
  </p>
</div>

---

<div align="left">

[![Flutter](../assets/badges/flutter.svg)](https://flutter.dev/)
[![Dart](../assets/badges/dart.svg)](https://dart.dev/)
[![Riverpod](../assets/badges/riverpod.svg)](https://pub.dev/packages/flutter_riverpod)
[![Freezed](../assets/badges/freezed.svg)](https://pub.dev/packages/freezed)
[![GoRouter](../assets/badges/gorouter.svg)](https://pub.dev/packages/go_router)
[![Flutter Localizations](../assets/badges/flutter_localizations.svg)](https://docs.flutter.dev/ui/internationalization)
[![Intl](../assets/badges/intl.svg)](https://pub.dev/packages/intl)
[![Very Good Analysis](../assets/badges/very_good.svg)](https://pub.dev/packages/very_good_analysis)
[![FVM](../assets/badges/fvm.svg)](https://fvm.app)
[![iOS](../assets/badges/ios.svg)](https://developer.apple.com/ios/)

</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about">About</a></li>
    <li>
      <a href="#style-guide">Style Guide</a>
      <ul>
        <li><a href="#color-palette">Color Palette</a></li>
      </ul>
    </li>
    <li><a href="#example-screens">Example Screens</a></li>
    <li>
      <a href="#riverpod">Riverpod</a>
      <ul>
        <li><a href="#what-is-riverpod">What is Riverpod</a></li>
        <li><a href="#why-riverpod">Why Riverpod</a></li>
        <li><a href="#watch-read-listen">watch, read, listen</a></li>
        <li><a href="#refresh-invalidate">refresh, invalidate</a></li>
        <li><a href="#three-switches">Three switches</a></li>
      </ul>
    </li>
    <li>
      <a href="#providers">Providers</a>
      <ul>
        <li><a href="#no-provider">No provider</a></li>
        <li><a href="#notifierprovider">NotifierProvider</a></li>
        <li><a href="#asyncnotifier-persistent-state">AsyncNotifier Persistent State</a></li>
        <li><a href="#asyncnotifier-non-persistent-state">AsyncNotifier Non-Persistent State</a></li>
        <li><a href="#stateprovider">StateProvider</a></li>
        <li><a href="#how-they-connect">How they connect</a></li>
      </ul>
    </li>
    <li>
      <a href="#freezed">Freezed</a>
      <ul>
        <li><a href="#what-is-freezed">What is Freezed</a></li>
        <li><a href="#why-freezed">Why Freezed</a></li>
        <li><a href="#custom-state-classes">Custom State Classes</a></li>
        <li><a href="#codegen">Codegen</a></li>
      </ul>
    </li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li>
      <a href="#testing">Testing</a>
      <ul>
        <li><a href="#testing-in-flutter">Testing in Flutter</a></li>
        <li><a href="#testing-riverpod">Testing Riverpod</a></li>
        <li><a href="#test-coverage">Test coverage</a></li>
      </ul>
    </li>
    <li><a href="#changelog">Changelog</a></li>
    <li><a href="#sources">Sources</a></li>
  </ol>
</details>

---

## About

This app is the **Riverpod** practice project in [Noir's Flutter Playground](../README.md).

The landing page has two sections: **Providers** and **Labs**.

**Providers** is the same counter five ways: local `setState`, `StateProvider`, `NotifierProvider`, then `AsyncNotifierProvider` with persistent and autoDispose lifetime. Details are under [Providers](#providers).

**Labs** go further. **AutoDispose Provider Lifetimes** compares persistent, autoDispose, and keep-alive on one screen. **User List** owns the `User` entity, the repository, and `UserListState`. **Add User** is a form that writes into that list — it imports User List directly (feature-first, no shared folder). **Listen Manual** puts `listen` in `build` next to `listenManual` in `initState`, so you can see which one runs when an error is already stored. **Consumer Widget** shows the same list twice: `StatelessWidget` + `Consumer` versus `ConsumerWidget`. **Refresh** is a fake GET /ping: `ref.refresh` is `invalidate` + `read`; `invalidate` is void. Folder layout follows the [playground architecture](../README.md#app-architecture-and-folder-structure). Shared UI lives in `shared_widgets/`. The UI locale is English; German ARBs stay for tests. See [Freezed](#freezed) for models, entities, and screen state.

[![iOS](../assets/badges/ios.svg)](https://developer.apple.com/ios/)

There is no Android project or Chrome. Run on the iOS Simulator.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Style Guide

Coming soon.

<p align="right"><a href="#readme-top">back to top</a></p>

### Color Palette

<img src="assets/color_palette.png" alt="Color palette">

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Example Screens

Coming soon.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## [Riverpod](https://pub.dev/packages/flutter_riverpod)

### What is Riverpod

Riverpod is a **state management and dependency injection** framework for Flutter.

A provider is a declared source of data. Widgets subscribe to it. When the data changes, only the widgets that watch it rebuild.

That is the whole idea: state lives outside the widget tree, and the UI reacts to it.

<p align="right"><a href="#readme-top">back to top</a></p>

### Why Riverpod

`setState` is fine for local UI, but it does not scale once several screens need the same value.

The older `provider` package works, but it depends on `BuildContext`. That leads to easy mistakes: reading a provider from the wrong place in the tree, or failing tests because the widget tree is missing an ancestor.

Riverpod avoids that:

- Providers are **global declarations**, not inherited widgets. You do not need `context` to create or read them.
- **Compile-safe**: a missing provider is a type error, not a runtime crash.
- **Testable**: you can override providers in tests without wrapping the whole tree in the right ancestors.
- **Explicit rebuilds**: `ref.watch` rebuilds, `ref.read` does not. You choose.

Use Riverpod when state is shared, async, or needs to be tested. Keep `setState` for tiny local UI that never leaves one widget.

**`ConsumerWidget`** is a `StatelessWidget` whose `build` already has `ref`. **`StatelessWidget` + `Consumer`** does the same `watch`, but you wrap a builder just to get `ref`. Prefer `ConsumerWidget`. **`ConsumerStatefulWidget`** only when you need `initState` / `dispose`. The **Consumer Widget** lab shows the first two on the same user list.

<p align="right"><a href="#readme-top">back to top</a></p>

### watch, read, listen

These three are how a widget talks to a provider. Match the call to the job.

**`ref.watch(provider)`** subscribes. When the value changes, this widget rebuilds. Use it in `build` to **show** the value (`final count = ref.watch(counterStateProvider)`).

**Do not `watch` in a button callback.** A tap is not a rebuild. The subscribe would be wasted, and it is easy to think the UI will update from that line. It will not.

**`ref.read(provider)`** is a one-shot lookup. No subscribe, no rebuild. Use it in `onPressed` and in tests (`container.read` is the same idea): `ref.read(counterStateProvider.notifier).state++`.

**Do not `read` in `build` for a value you display.** The widget will not rebuild when the provider changes, so the text stays stale.

**`ref.listen(provider, (previous, next) { ... })`** runs a callback when the value **changes**. Use it for **side effects**: snackbar, dialog, navigation. Not for putting the number on screen — that is `watch`. A snackbar in `build` after `watch` would fire on every rebuild (keyboard, rotation, parent notify). `listen` fires once per change.

Call `listen` in `build`. Riverpod registers it; it does not stack a new subscription every frame. Do not put it in `onPressed`.

The callback gets `(previous, next)`. Add User ignores `previous` (`_`) and acts on `next`. Guard the “nothing happened” values: `if (!isAdded) return;` / `if (error == null) return;` so the reset after the side effect does not loop.

**`.select`** listens to one field so a list update does not open the duplicate-id dialog:

```
ref.listen(addUserProvider.select((state) => state.isAdded), (_, isAdded) { ... });
ref.listen(addUserProvider.select((state) => state.error), (_, error) { ... });
```

**One-shot flags.** `isAdded` is not “the user exists”. It is “show the snackbar now”. After the snackbar, **`acknowledgeAdded()`** sets it back to `false`. Without that, the next successful add is `true` → `true` and `listen` does not run. Same idea for `error` + **`clearError()`** after the dialog. Add User does this for the form; User List does it for `fetchUsers` errors.

**Use `listen` when** something must happen *because the value changed*, once, and is not a widget on screen.

**Do not use `listen` when** you need the value in the tree. That is `watch`. Do not `watch` a flag only to `showSnackBar` in `build`.

**`ref.listenManual`** is for `initState` (`ref.listen` / `ref.watch` are illegal there) plus **`fireImmediately: true`**: current value *and* later changes. The same snapshot without a subscription is **`ref.read` in `initState`**. `read` has no callback, so it never shows a dialog or SnackBar — the gray card is the whole effect. The **Listen Manual** lab color-codes the four APIs: purple `watch`, gray `read`, red `listenManual` (dialog), teal `listen` (SnackBar). Store an error while the screen is open: teal SnackBar + red dialog; gray `read` stays empty. Leave and come back: purple `watch` and gray `read` are filled; red dialog again; teal `listen` stays empty. `showDialog` waits until after the first layout. Close the `ProviderSubscription` in `dispose`.

Use `listenManual` when the side effect must see the current value on first open, or you must start/stop the listener outside `build`. Add User and User List stay on `listen` in `build`.

<p align="right"><a href="#readme-top">back to top</a></p>

### refresh, invalidate

These two tell Riverpod: **run this provider again**. They are not `watch` / `read` / `listen`. They are also not a method on a notifier (`fetchUsers()`, `reset()`).

**`ref.refresh(provider)` is always `invalidate` plus an immediate `read`.** Writing:

```
ref.refresh(provider);
```

is the same as:

```
ref.invalidate(provider);
ref.read(provider);
```

That `read` is why refresh **returns** the new value. On a `FutureProvider`, `ref.refresh(provider.future)` is the new GET as a `Future` — pull-to-refresh awaits that. `RefreshIndicator.onRefresh` needs a `Future`; `invalidate` is `void` and cannot go there.

**`ref.invalidate(provider)`** is **void**. Marks the provider stale. If something is watching, the GET runs again now. If nobody is looking, it waits until the next `watch` / `read`. Prefer **invalidate** unless this callback must wait. Several invalidates collapse into one rebuild; several refreshes do not.

The **Refresh** lab has its **own** `FutureProvider`: a delayed fake GET /ping. Fetch count is `.next()` on a **second** provider (`refreshPingCountProvider`). The Refresh button stays on **Waiting on Future…** until `await` completes. **Refresh 3x** stays on **Waiting on 3 Futures…**. Those two buttons disable while they wait so you cannot stack taps — that is our UI, not a Riverpod rule. Invalidate stays enabled while a Refresh waits. **Invalidate 3x** vs **Refresh 3x**: three invalidates schedule one GET; three refreshes start three. The **Refresh** button blinks once; **Refresh 3x** blinks three times. Prefer **invalidate** when this callback does not need to wait: save, delete, logout, or any stale cache. Whoever **watch**es reloads. `when(..., skipLoadingOnRefresh: false)` so the spinner shows.

This is not User List. `userListProvider.build()` returns empty state; the GET is `fetchUsers()`. Refreshing that provider would wipe the list. The async screens' refresh FAB is `reset()` on the notifier — same idea, not `ref.refresh`.

<p align="right"><a href="#readme-top">back to top</a></p>

### Three switches

Three independent knobs. Mixing them is why `listenManual` feels like `autoDispose`.

| Switch | What it is |
| --- | --- |
| **Provider** | The mailbox. The value lives in it. `watch` / `read` the mailbox. |
| **Notifier** | Who may put letters in (`storeError()` / `clearError()`). Write with `.notifier`. A `NotifierProvider` is mailbox **plus** person. |
| **autoDispose** | When nobody is looking, throw the state away. Next open: empty. Without it, Back keeps whatever was in the mailbox. Not `listen`. |
| **`listen`** | Callback only in `build`, and only when the value **changes** while this screen is open. |
| **`listenManual`** | Same listening, but you start it in `initState` and `close()` it in `dispose`. `fireImmediately: true` also reports what is already in the mailbox. |

`listenManual` does not hold the state. `autoDispose` is not “Notifier instead of Provider”.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Providers

A provider is the declared source of state. The type you pick is how that state is allowed to change. The same counter in this app shows the steps: local `setState`, a `Notifier` class, an `AsyncNotifier` when the first value is a `Future` (kept alive or auto-disposed), and `StateProvider` as the shortcut.

<p align="right"><a href="#readme-top">back to top</a></p>

### No provider

No provider means the count lives in the widget with `setState`. Nothing outside that screen can read it.

**Use it when** only one widget cares: an expansion tile, a password-field visibility toggle, a one-off animation flag.

**Do not use it when** a second screen needs the same count, you want to test the increment without pumping the widget, or the value must survive leaving the page. That is when you lift it into a provider.

<p align="right"><a href="#readme-top">back to top</a></p>

### NotifierProvider

`NotifierProvider` is the default way to hold **mutable state outside the widget**. Updates go through a **class with methods**. The widget calls `increment()` or `applyFilter()`. The notifier owns the rules.

This is the type everything else is built on. A `StateProvider` is a notifier whose public API is only `state`. **AutoDispose Provider Lifetimes** puts three lifetimes on one screen: plain `NotifierProvider` (Persistent), `NotifierProvider.autoDispose` (Non-Persistent), and autoDispose plus `keepAlive` for 5 seconds after Back. **User List** and **Add User** each put a custom state class on a notifier, not `List<User>` and not a read-only `Provider`. See [Custom State Classes](#custom-state-classes).

**Use it when** the value leaves the widget: plus and minus must not go below zero, a form field needs validation, a list can add and remove items, or two screens share the same actions. Use it as soon as you would write a test for the change.

**Do not use it when** the value never changes (that is a read-only `Provider`) or the widget is the only thing that ever sees a one-off toggle. Do not reach for a notifier to store a theme color constant. Do not use it when the first value is a `Future` — that is `AsyncNotifierProvider`.

<p align="right"><a href="#readme-top">back to top</a></p>

### AsyncNotifier Persistent State

`AsyncNotifierProvider` is the same class-and-methods idea, but `build` returns a `Future`. Riverpod stores **`AsyncValue<T>`**: loading, error, data.

This screen uses a **plain** `AsyncNotifierProvider` (`isAutoDispose: false`). The count lives **in memory** on that notifier, not on disk. The notifier lives as long as `ProviderScope` (the app). Leave with the back button, open the screen again: **same count, no loading**.

`ref.watch` is therefore not an `int`. It is `AsyncValue<int>`. **`when`** maps each state to UI: `loading` (spinner), `error` (`ErrorWidget`), `data` (the counter). Skip a callback and that state has no widget. `switch` on `AsyncValue` does the same job.

Do not read `.value` or `.value!` in `build` to “just show the number”. While `build()` is still awaiting, there is no number yet. Buttons still `ref.read(...notifier)` like the sync screen. `when` is only for rendering.

**`build`, `state`, and `future` are one object.** The provider holds a single `PersistentStateAsyncNotifier`. First `watch`/`read`: Riverpod constructs it and calls `build()`. While `build()` awaits, `state` is `AsyncLoading`. `build()` `return`s `0` → `state = AsyncData(0)`. That return value **is** the first `state`.

`future` is not the `Future.delayed` in `build()`. It is a getter on `AsyncNotifier`: unwrap `state` as `int` once it is no longer loading. After `build()` finished, `await future` is `0`. The `<int>` on `AsyncNotifier<int>` is why that value is an `int`. Plus calls `.increment()` on **that same instance**; `await future` reads the current `state`, then `state = AsyncData(current + 1)` replaces it. `build()` does not run again.

**`AsyncValue.guard`** is the clean way to turn a `Future` into `AsyncValue` without writing try/catch. `state = await AsyncValue.guard(fakeApi)` → success becomes `AsyncData`, `throw` / `Future.error` becomes `AsyncError`. `guard` does **not** set loading. Both async screens still assign `state = const AsyncLoading()` first so the spinner shows now. `reset()` uses this path. The commented `throw` inside `reset()` is how you would fake a failed reload instead of returning `0`.

The **`error`** branch is not empty theory. The screen counts **page enters** once in `initState` (not in `build()`, or every rebuild would increment) and calls `onPageEntered()`. `build()` on the notifier does not run again (no `autoDispose`), so the visit count lives on that notifier. Every 3rd enter (`visit % 3 == 0`) sets `AsyncLoading`, then `guard` throws `FakePageEnterException` → `AsyncError`. Visit 4 restores the **persisted** count. Same notifier; the error was only a state. The UI is **`ErrorWidget`** (`lib/shared_widgets/error_widget.dart`): `assets/img/error_dragon.png` and `l10n.errorOccurred`. Imports `hide ErrorWidget` because Flutter already uses that name for the build-failure fallback.

`when` defaults **`skipLoadingOnRefresh: true`**. After `invalidate` the widget would keep painting the old number until the Future finishes. Both async screens set `skipLoadingOnRefresh` / `skipLoadingOnReload` to **false** so `loading:` runs on reset. The **Refresh** lab does the same for `ref.refresh` / `ref.invalidate`.

**Use it when** the first value comes from a repository, HTTP, or disk, and the result should survive leaving the screen (a profile you still need on the next page).

**Do not use it when** the number is already in memory and there is no `Future`. That is `NotifierProvider`. Do not wrap a local counter in `AsyncValue` just to look async.

<p align="right"><a href="#readme-top">back to top</a></p>

### AsyncNotifier Non-Persistent State

Same `AsyncNotifier` class, same `when`, same plus / minus / **reset** FAB, same `build` → `state` → `future` chain (see Persistent State). The `error` branch uses the same **`ErrorWidget`**. The only code difference is **`AsyncNotifierProvider.autoDispose`**. There is no SharedPreferences, no `keepAlive`, no extra cache. “Non-persistent” here means **lifetime**: the count lives in memory only while something `watch`es it.

How that lifetime works:

1. The screen `ref.watch`es the provider. That listener keeps the notifier alive.
2. Plus / minus write `state` on that same in-memory notifier.
3. **Back** pops the screen. The widget is gone, last watcher is gone, Riverpod **disposes** the notifier. Count `5` does not exist anymore.
4. Open the screen again: a **new** notifier, `build()` runs, spinner, count is **0**.

**Reset** is a different path. The refresh FAB stays on the page, assigns `AsyncLoading`, then `AsyncValue.guard` (same as Persistent State). It does not dispose the provider. The two screens only differ on **leave**.

**Use it when** the async state belongs to that screen only: a form fetch, a one-off detail page, a retryable request you do not want to keep in memory after pop.

**Do not use it when** another route still needs the same `AsyncValue` after you leave. That is Persistent State (no `autoDispose`).

<p align="right"><a href="#readme-top">back to top</a></p>

### StateProvider

`StateProvider` is **not** a second kind of state. It is a pre-built notifier that holds **one mutable value**. The UI writes `state` directly. There are no named methods and no place for rules.

In Riverpod 3 `StateProvider` is **legacy** (`legacy.dart`). Do not start a feature with it. Fine to recognize in older code or to lift a throwaway `int`. New mutable state goes through `NotifierProvider`.

**Use it when** the value is a primitive or enum, any write is valid, and nothing else depends on how it changed. Typical cases: a selected tab, a filter chip, a “dark mode” switch, a counter you will throw away.

**Do not use it when** two writes must stay consistent, a value has a floor or a max, more than one field changes together, or you would want to unit-test the update. Do not use it for login, a cart, or anything that talks to an API. Use `NotifierProvider`.

<p align="right"><a href="#readme-top">back to top</a></p>

### How they connect

Conceptually there is one ladder:

1. **No provider** — `setState` on one screen. Fine while nobody else needs the count.
2. **NotifierProvider** — same number, now a class outside the widget. Writes go through methods.
3. **AsyncNotifier Persistent State** — `build` is a `Future`. In memory for the app, not disk. Leave the page; the count stays.
4. **AsyncNotifier Non-Persistent State** — same class, only `.autoDispose`. Leave the page; last watcher gone, notifier disposed, next visit loads from scratch.
5. **StateProvider** — the same notifier with the class stripped off. Writes are `state++`. Legacy in Riverpod 3.

The app screens still go `setState` → `StateProvider` → `NotifierProvider` → Persistent AsyncNotifier → Non-Persistent AsyncNotifier. That is the smallest syntax jump from a widget field, then you write the class, then the class may wait, then you choose whether that wait survives a pop. Read the types the other way around: the class is the foundation, async is the class plus `AsyncValue`, `autoDispose` is lifetime, the shortcut is optional.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## [Freezed](https://pub.dev/packages/freezed)

### What is Freezed

Freezed generates **immutable data classes**. You write the fields. It writes `==`, `hashCode`, `toString`, `copyWith`, and (if you ask) union types.

That is a **data class**, not a provider. Riverpod holds and updates state. Freezed is the shape of a value you put *in* that state: a domain entity, a JSON model, a [custom state class](#custom-state-classes). A `String` username on AutoDispose Provider Lifetimes does not need Freezed. The User List `User`, **`UserListState`**, and Add User **`UserState`** do.

`freezed_annotation` is what you import in app code (`@freezed`). `freezed` is the generator. It lives in `dev_dependencies` because the app never imports it at runtime.

<p align="right"><a href="#readme-top">back to top</a></p>

### Why Freezed

Hand-written models get stale. You add a field and forget `==` or `copyWith`. Tests compare objects and fail for the wrong reason. JSON parsing lives in `fromJson` that nobody wants to maintain.

Freezed keeps those in sync with the constructor:

- **Immutable**: no `user.name = …`. Change means `copyWith(name: …)` and a new instance. That matches how Riverpod wants you to replace `state`, not mutate it in place.
- **Equality**: two users with the same fields are equal. Useful in tests and in `ref.listen`.
- **Unions**: a result that is `loading` / `data` / `error` as sealed types, not a pile of nullable fields. Pattern-match with `switch`.
- **JSON**: add a `fromJson` factory; **json_serializable** fills `toJson` / `fromJson`. Freezed does not parse JSON by itself.

**Use it when** the value has more than one field, comes from an API, must be copied with one field changed, or you would write `==` by hand. Typical: a `User` entity, **`UserListState`** (`users`, `isLoading`, `error`), **`UserState` on Add User** (`isAdded`, `error`), a DTO next to a repository, a sealed `Result`.

**Do not use it when** the value is one `int` or `String` (the counters, the AutoDispose Provider Lifetimes name). Do not Freezed a widget. Do not put JSON parsing in the UI — map API models to entities in the repository, then hold entities in the provider.

<p align="right"><a href="#readme-top">back to top</a></p>

### Custom State Classes

A **custom state class** is the value on a `Notifier` when one `int` or `List<T>` is not enough. The notifier still owns the methods. The class is the snapshot those methods replace with `copyWith`.

The counters and AutoDispose Provider Lifetimes put a single `int` or `String` on the provider. **User List** cannot. The screen needs the `User` list *and* `isLoading` and `error` in the same update. **Add User** has its own smaller snapshot: `isAdded` and a duplicate-id `error`.

**`UserListState`** (`lib/features/labs/user_list/presentation/providers/user_list_state.dart`) owns the list. **`UserState`** (`lib/features/labs/add_user/presentation/providers/user_state.dart`) owns the form flags. Both are Freezed. Presentation, not domain entities. Add User writes through `userListProvider`; it does not keep a second copy of the list.

Why not a plain provider of the list:

- A read-only `Provider<List<User>>` cannot run `addUser` or `fetchUsers`.
- `Notifier<List<User>>` holds only the list. The flags would be extra providers you have to keep in sync.
- `AsyncValue<List<User>>` is loading / error / data. It has no `isAdded` for the SnackBar, and `addUser` is synchronous.

One `copyWith` replaces `state`. One `ref.watch` per notifier. `ref.listen` + `.select` on `isAdded` or `error` for side effects, then reset the flag (`acknowledgeAdded` / `clearError`). See [watch, read, listen](#watch-read-listen).

**Use a custom state class when** several fields must change together and at least one is not the domain object itself (loading, a one-shot UI flag, a form error).

**Do not use one when** the notifier holds a single `int` or `String`. That is still `Notifier<int>`.

<p align="right"><a href="#readme-top">back to top</a></p>

### Codegen

Three generators share **build_runner**. They write files you never edit:

| Annotation | Package (dev) | Output | Job |
| --- | --- | --- | --- |
| `@freezed` | `freezed` | `*.freezed.dart` | `copyWith`, `==`, unions |
| `@JsonSerializable` / Freezed `fromJson` | `json_serializable` | `*.g.dart` | JSON |
| `@riverpod` | `riverpod_generator` | `*.g.dart` | provider class from a function or `Notifier` |

`json_annotation` and `riverpod_annotation` are the runtime annotations, same split as `freezed_annotation` vs `freezed`.

A tiny `Provider` / `FutureProvider` is almost the same length with or without codegen — you still write what goes in the mailbox. The win is **family + autoDispose + AsyncNotifier**. By hand you type `AsyncNotifierProvider.autoDispose.family<UserByIdNotifier, User, int>(UserByIdNotifier.new)`, a constructor that stores `id`, and `extends AsyncNotifier<User>` with `build()` taking no argument. With `@riverpod` that is `class UserById extends _$UserById` and `build(int id)` — the generator keeps `id` for you. No screen; compare `lib/features/labs/codegen/presentation/providers/user_by_id_provider.dart` with `user_by_id_provider_manual.dart`. The Refresh lab's ping uses codegen too; that one is the small-savings case.

`part 'user.freezed.dart';` and `part 'user.g.dart';` glue those files to your source. Change the source, then run:

```
fvm dart run build_runner build --force-jit
```

`--force-jit` is required here: build_runner 2.16 defaults to AOT compilation of the builders, and that snapshot can deadlock (stuck at `0s riverpod_generator`, 0% CPU). JIT finishes a full run in about 10s.

Or the Cursor / VS Code task **Build Runner** (Command Palette → **Tasks: Run Task** → **Build Runner**). **Build Runner Watch** keeps generating while you edit.

`watch` instead of `build` while you edit models.

Do not edit `*.freezed.dart` or `*.g.dart`. `analysis_options.yaml` excludes them. `invalid_annotation_target` is ignored so `@JsonKey` on Freezed fields does not warn.

The User List lab splits that shape in two, then both labs add a [custom state class](#custom-state-classes). **`User`** is the domain entity (`lib/features/labs/user_list/domain/entities/user.dart`) — no JSON. **`UserModel`** is the data model (`lib/features/labs/user_list/data/models/user_model.dart`) — `fromJson` / `toJson`, plus `toEntity()` / `toModel()`. `InMemoryUserRepository` is where that mapping runs. **`UserListState`** is the list snapshot: `users` plus `isLoading` and `error`. **`UserState`** on Add User is only `isAdded` and `error`. Screens hold `User` entities, not `UserModel`. Add User imports User List; there is no shared users folder.

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
cd riverpod_basics
fvm install
fvm flutter pub get
fvm dart run build_runner build --force-jit
fvm flutter run
```

`fvm flutter run` uses the **iOS Simulator**. There is no Android project or Chrome.

After you add or change a `@freezed` / `@riverpod` type, run `build_runner` again. See [Codegen](#codegen).

This project is pinned with [FVM](https://fvm.app). After `fvm install`, Cursor uses the SDK at `.fvm/flutter_sdk`.

Packages live in `pubspec.yaml` (do not copy versions from this README; they move). Runtime: `flutter_riverpod`, `go_router`, `freezed_annotation`, `json_annotation`, `riverpod_annotation`, `intl`, `cupertino_icons`. Dev: `freezed`, `json_serializable`, `riverpod_generator`, `build_runner`, `very_good_analysis`.

<p align="right"><a href="#readme-top">back to top</a></p>

---

## Testing

A test is a small program that checks your code. It does not change the app. You run an action, then **assert** that the result is what you meant.

`expect(actual, matcher)` is that assertion: left is what happened, right is what must be true. If they differ, the test fails. That is the point — you catch the break before a user does.

Keep tests deterministic. One test, one claim. Do not depend on the order of other tests.

<p align="right"><a href="#readme-top">back to top</a></p>

### Testing in Flutter

`flutter_test` is the same idea on a fake widget tree. You do not need a simulator for these.

- **`test`** — no widgets. Use it for logic and providers.
- **`testWidgets`** — a screen via `WidgetTester`.
- **`pumpWidget`** — put a widget on that screen.
- **`find.text` / `find.byIcon`** — locate widgets.
- **`tester.tap`** — a user gesture.
- **`pump`** — one frame. Use it after `setState` or a provider notify.
- **`pumpAndSettle`** — wait until animations and `go_router` finish.
- **`addTearDown`** — cleanup after **this** test, pass or fail. Do not put `dispose()` only at the bottom of the happy path: a failing `expect` would skip it.

`test/` mirrors `lib/`. Each source file has a matching `*_test.dart` in the same folders (`features/providers/`, `presentation/`, `core/router/`, `shared_widgets/`).

<p align="right"><a href="#readme-top">back to top</a></p>

### Testing Riverpod

**Dependency injection** means a unit does not construct its own dependencies (API, database, clock). They are passed in. In a test you pass a fake, so nothing hits the network. That is why DI is so useful for tests.

Riverpod **is** that injection. `ProviderScope` and `ProviderContainer` hold the graph. `overrideWith` replaces one node. You do not add GetIt for feature state. GetIt is also DI; a second locator is only worth it in a mixed codebase that already uses it. This playground stays on Riverpod.

Two shapes:

**Provider tests** have no widgets. You build a `ProviderContainer`, `read` the provider, call methods on `.notifier`, then dispose. Same Riverpod calls as in the app, but `container.read` instead of `ref.read`. See [watch, read, listen](#watch-read-listen).

**Widget tests** pump a screen. Wrap the tree in `ProviderScope` (the app already does this in `main.dart`). Tap, then assert text.

Lifetime tests (AutoDispose Provider Lifetimes) still use a `ProviderContainer`. Close the last listener and the autoDispose provider is gone. A persistent one is still there. Keep Alive uses `fakeAsync` so 5 seconds pass without a real wait.

User List provider tests cover `fetchUsers`, `ensureLoaded`, and `addUser`. Add User provider tests cover writing through that list and a duplicate id. Widget tests fake the repository with `overrideWith` so nothing hits a delay or seed data. The Listen Manual widget test seeds the stored error with `overrideWith` so `fireImmediately` can show the dialog without a tap.

`addTearDown(container.dispose)` drops listeners and cached state so the next test starts clean.

- **`ProviderScope`** — widget that creates the container for the real app and for widget tests.
- **`ProviderContainer`** — the same world without widgets. Use it in provider tests.
- **`overrideWith`** — replace a provider in this scope/container so tests never hit a real API.

### Test coverage

<!-- coverage-percent:start -->
**89.1%** line coverage (1141 of 1280 lines).
<!-- coverage-percent:end -->

![Coverage](assets/coverage/card.svg)

The card and the header badge are regenerated on **playground commit** (git hooks at the repo root) when tests pass. A failing test does not block the commit; **push** still requires green tests (`pre-push`). GitHub Actions runs tests on Linux and does **not** commit the SVGs. `fvm flutter test --coverage` only writes local `lcov.info` for **Coverage Gutters**, and only for files the tests loaded. Unused `lib/` files are added as 0 hits when the playground generator runs. Saving a Dart file does not update the SVGs by itself.

```
cd riverpod_basics
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

- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
- [go_router](https://pub.dev/packages/go_router)
- [freezed](https://pub.dev/packages/freezed)
- [json_serializable](https://pub.dev/packages/json_serializable)
- [riverpod_generator](https://pub.dev/packages/riverpod_generator)
- [build_runner](https://pub.dev/packages/build_runner)
- [very_good_analysis](https://pub.dev/packages/very_good_analysis)
- [Flutter Riverpod For Complete Beginner](https://www.udemy.com/course/flutter-riverpod-for-complete-beginner/) — [Richard Dewan](https://github.com/rddewan)

<p align="right"><a href="#readme-top">back to top</a></p>

