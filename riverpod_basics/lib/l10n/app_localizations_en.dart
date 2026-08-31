// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Riverpod Basics';

  @override
  String get noProvider => 'No Provider';

  @override
  String get stateProvider => 'StateProvider';

  @override
  String get notifierProvider => 'NotifierProvider';

  @override
  String get asyncNotifierPersistentState => 'AsyncNotifier Persistent State';

  @override
  String get asyncNotifierNonPersistentState =>
      'AsyncNotifier Non-Persistent State';

  @override
  String get errorOccurred => 'Unfortunately, an error occurred.';

  @override
  String get errorNetwork =>
      'Could not reach the server. Check your connection.';

  @override
  String get errorNotFound => 'That item was not found.';

  @override
  String buttonPressCount(int count) {
    return 'You have pressed the button this many times: $count';
  }

  @override
  String get pageNotFound => 'Page not found';

  @override
  String get goToLanding => 'Go to landing';

  @override
  String get providers => 'Providers';

  @override
  String get labs => 'Labs';

  @override
  String labNumber(int number) {
    return 'Lab $number';
  }

  @override
  String get persistent => 'Persistent';

  @override
  String get nonPersistent => 'Non-Persistent';

  @override
  String keepAliveForSeconds(int seconds) {
    return 'Keep Alive $seconds Seconds';
  }

  @override
  String get keepAliveOnResume => 'Keep Alive: onResume (Timer stopped)';

  @override
  String get keepAliveOnDispose => 'Keep Alive: onDispose';

  @override
  String get username => 'Username';

  @override
  String get add => 'Add';

  @override
  String get providerLifetimes => 'AutoDispose Provider Lifetimes';

  @override
  String get addUser => 'Add User';

  @override
  String get userList => 'User List';

  @override
  String get userSearch => 'User Search';

  @override
  String get userSearchHint => 'Name or id';

  @override
  String get userSearchAction => 'Search';

  @override
  String get userSearchNotFound => 'No user matched that search.';

  @override
  String get userSearchNotifierLabel => 'Notifier';

  @override
  String get userSearchFamilyLabel => 'Family';

  @override
  String get userSearchBody =>
      '**Notifier** holds one cache: **search()** overwrites it, like User List **fetchUsers**. **Family** puts the query on the key — **userSearchFamilyProvider(\'Grace\')** and **(\'10\')** are two caches. Family state is **AsyncValue**, not UserSearchState.';

  @override
  String userValue(String name) {
    return 'User: $name';
  }

  @override
  String get id => 'Id';

  @override
  String get age => 'Age';

  @override
  String get email => 'Email';

  @override
  String get fieldRequired => 'Required.';

  @override
  String get invalidNumber => 'Enter a number.';

  @override
  String get invalidEmail => 'Enter a valid email.';

  @override
  String get duplicateUserId => 'A user with this id already exists.';

  @override
  String get duplicateEmail => 'A user with this email already exists.';

  @override
  String get userAdded => 'User added.';

  @override
  String get errorTitle => 'Error';

  @override
  String get listenManual => 'Listen Manual';

  @override
  String get listenManualBody =>
      'Same stored error, four colors. Purple watch is always the live value — filled after Back. Gray read is frozen at open. Red listenManual is the dialog (also on reopen). Teal listen is the SnackBar and stays empty on the second visit.';

  @override
  String get listenManualWatchLabel => 'watch';

  @override
  String get listenManualIdle => 'Live value. Empty now.';

  @override
  String get listenManualStored => 'Live value. Filled — survives Back.';

  @override
  String get listenManualStoreError => 'Store an error';

  @override
  String get listenManualClearError => 'Clear error';

  @override
  String get listenManualFetchFailed =>
      'Could not load. This stays until you tap Clear error.';

  @override
  String get listenManualManualLabel => 'listenManual';

  @override
  String get listenManualManualIdle => 'No stored error on open.';

  @override
  String get listenManualManualFired =>
      'Ran on open — error was already stored.';

  @override
  String get listenManualListenLabel => 'listen';

  @override
  String get listenManualListenIdle => 'No change this visit.';

  @override
  String get listenManualListenFired => 'Saw a change this visit.';

  @override
  String get listenManualListenSnackBar => 'listen: the value changed.';

  @override
  String get listenManualReadLabel => 'read';

  @override
  String get listenManualReadIdle =>
      'Snapshot at open: null. Store an error will not change this.';

  @override
  String get listenManualReadFired =>
      'Snapshot at open: stored error. initState ran again.';

  @override
  String get consumerWidget => 'Consumer Widget';

  @override
  String get consumerWidgetBody =>
      'Both panels show the same users because they **watch** the same provider.\n\nTop: a **StatelessWidget** wraps **Consumer** only to get **ref**.\n\nBottom: **ConsumerWidget** — **build** already has **ref**, so there is no wrapper. Prefer **ConsumerWidget**.\n\nUse **ConsumerStatefulWidget** only when you need **initState** or **dispose**.';

  @override
  String get consumerWrapLabel => 'StatelessWidget + Consumer';

  @override
  String get consumerWidgetLabel => 'ConsumerWidget';

  @override
  String get addDemoUser => 'Add demo user';

  @override
  String get quote => 'Quote';

  @override
  String get quoteBody =>
      'The screen **watch**es both **FutureProvider**s — one per card. Both rebuild on **AsyncValue**: loading, data, error. Each GET picks a random quote.\n\n**FutureProvider** has no extra input. **Get new quote** **invalidate**s that cache so the GET runs again. **Fail call** sets a flag on the data source, then **invalidate**s that provider. A field on an object is not provider state.\n\n**FutureProvider + input** — not the screen — **watch**es the quote number. **Increment number** adds one. Riverpod re-runs this GET with no **invalidate**. The other card stays put. That is the Future equivalent of **search()** assigning **state**.\n\nThe failed GET throws **NetworkException**. The repository maps it to **NetworkFailure**.\n\n`retry` is null so Riverpod 3 does not retry that error off the screen (~200ms). Without it **Fail call** never stays.\n\nA **SnackBar** is a debug print of the Riverpod calls, not the button. **Get new quote** → **invalidate() → watch()**. **Fail call** → **read() + invalidate() → watch()** (notifier). **Increment number** → **read() → watch()** — the Future **watch**es the number, no **invalidate**.';

  @override
  String get quoteWatchLabel => 'FutureProvider';

  @override
  String get quoteFromInputLabel => 'FutureProvider + input';

  @override
  String get quoteReload => 'Get new quote';

  @override
  String get quoteIncrementNumber => 'Increment number';

  @override
  String get quoteFailCall => 'Fail call';

  @override
  String get labSnackBarRead => 'read()';

  @override
  String get labSnackBarReadWatch => 'read() → watch()';

  @override
  String get labSnackBarReadUnwatch => 'read() → unwatch';

  @override
  String get labSnackBarInvalidate => 'invalidate()';

  @override
  String get labSnackBarInvalidateWatch => 'invalidate() → watch()';

  @override
  String get labSnackBarReadAndInvalidate => 'read() + invalidate() → watch()';

  @override
  String get tick => 'Tick';

  @override
  String get tickBody =>
      'The screen **watch**es one handwritten **StreamProvider** while **Start** is on. **AsyncValue** is loading, then a new **data** on every tick, or **error**.\n\nA **FutureProvider** (Quote) runs once. A **StreamProvider** keeps listening. **watch** rebuilds on each event.\n\n**Stop** drops the **watch**. `autoDispose` cancels the fake **/tick** stream and the timer. **Start** watches again — a new stream at tick 1.\n\n**Invalidate** is a new listen on the same provider, still at tick 1, without Stop. Like a new GET on Quote.\n\n**Fail call** sets a flag on the data source. The next tick throws **NetworkException**. The repository maps it to **NetworkFailure**. **AsyncValue** is **error**. **watch** stays. No **invalidate** on that tap — the error is the next event. **Start** after that starts a new stream (**invalidate** while still **watch**ing).\n\n`retry` is null so Riverpod 3 does not retry that error off the screen (~200ms). Without it **Fail call** never stays.\n\nA **SnackBar** is a debug print of the Riverpod calls, not the button. **Start** from stopped → **read() → watch()**. **Start** after **Fail call** → **invalidate() → watch()** (new stream). **Stop** → **read() → unwatch**. **Invalidate** → **invalidate() → watch()**. **Fail call** → **read()**.';

  @override
  String get tickWatchLabel => 'StreamProvider';

  @override
  String get tickStart => 'Start';

  @override
  String get tickStop => 'Stop';

  @override
  String get tickStopped => 'Stopped.';

  @override
  String get tickReload => 'Invalidate';

  @override
  String get tickFailCall => 'Fail call';

  @override
  String tickBeat(int n, String time) {
    return 'Tick $n · $time';
  }

  @override
  String get refreshLab => 'Refresh';

  @override
  String get refreshLabBody =>
      '**refresh** is always **invalidate** plus an immediate **read**. That is why refresh returns a Future. Use **refresh** when this callback must wait. **Pull-to-refresh** is the usual case.\n\nUse **invalidate** when you do not need to wait. It marks the provider stale. Whoever **watch**es it reloads. That is the usual choice after a mutation: save, delete, logout, or any time the cache is old.\n\n**Refresh** and **Refresh 3x** disable while they wait so you cannot stack taps. **Invalidate** stays tappable.\n\n**Invalidate 3x** starts one GET. **Refresh 3x** starts three. The **Refresh** button blinks once. **Refresh 3x** blinks three times.';

  @override
  String get refreshLabWatchLabel => 'watch';

  @override
  String get refreshLabLoading => 'Loading…';

  @override
  String refreshLabPing(int n, String time) {
    return 'Fetch $n · $time';
  }

  @override
  String get refreshLabRefresh => 'Refresh';

  @override
  String get refreshLabWaitingOnFuture => 'Waiting on Future…';

  @override
  String get refreshLabWaitingOnThreeFutures => 'Waiting on 3 Futures…';

  @override
  String get refreshLabInvalidate => 'Invalidate';

  @override
  String get refreshLabRefreshThree => 'Refresh 3x';

  @override
  String get refreshLabInvalidateThree => 'Invalidate 3x';

  @override
  String get auth => 'Auth';

  @override
  String get authWatchLabel => 'GoRouter + Notifier';

  @override
  String get authBody =>
      'Auth is a **Notifier** (`login()` / `logout()`). **goRouterProvider** is a read-only **Provider** that holds one **GoRouter**. It must not **watch** `authProvider`: that would build a new **GoRouter** and drop the stack. **listen** + **refreshListenable** instead.\n\n**Next Screen** always **goNamed**s **/auth/next**. Logged out, **redirect** sends you to **/auth/login?from=/auth/next**. Submit writes the Notifier. **redirect** then uses **from** — Next Screen — or the hub if you opened **Log in** yourself.\n\nA **SnackBar** is a debug print of the GoRouter calls, not the button. **Log in** / **Next Screen** while allowed → **goNamed()**. Logged-out **Next Screen** → **goNamed() → redirect()**. Submit → **redirect()**. This lab does not use **pushNamed**.';

  @override
  String get authLogin => 'Log in';

  @override
  String get authLogout => 'Log out';

  @override
  String get authNextScreen => 'Next Screen';

  @override
  String get authUnauthorized => 'Not authorized. Please log in.';

  @override
  String get authUsername => 'Username';

  @override
  String get authPassword => 'Password';

  @override
  String get authSubmit => 'Log in';

  @override
  String get authSnackGoNamed => 'goNamed()';

  @override
  String get authSnackGoNamedThenRedirect => 'goNamed() → redirect()';

  @override
  String get authSnackRedirect => 'redirect()';
}
