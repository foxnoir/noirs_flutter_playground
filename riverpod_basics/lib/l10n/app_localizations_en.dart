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
  String get fetchUsersFailed => 'Could not load users.';

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
}
