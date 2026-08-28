// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Riverpod Basics';

  @override
  String get noProvider => 'Kein Provider';

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
  String get errorOccurred => 'Es ist leider ein Fehler aufgetreten.';

  @override
  String get errorNetwork =>
      'Der Server ist nicht erreichbar. Prüfe die Verbindung.';

  @override
  String get errorNotFound => 'Dieser Eintrag wurde nicht gefunden.';

  @override
  String buttonPressCount(int count) {
    return 'Du hast den Button so oft gedrückt: $count';
  }

  @override
  String get pageNotFound => 'Seite nicht gefunden';

  @override
  String get goToLanding => 'Zur Startseite';

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
  String get username => 'Benutzername';

  @override
  String get add => 'Hinzufügen';

  @override
  String get providerLifetimes => 'AutoDispose Provider Lifetimes';

  @override
  String get addUser => 'Benutzer hinzufügen';

  @override
  String get userList => 'Benutzerliste';

  @override
  String get userSearch => 'Benutzersuche';

  @override
  String get userSearchHint => 'Name oder Id';

  @override
  String get userSearchAction => 'Suchen';

  @override
  String get userSearchNotFound => 'Kein Benutzer gefunden.';

  @override
  String get userSearchNotifierLabel => 'Notifier';

  @override
  String get userSearchFamilyLabel => 'Family';

  @override
  String get userSearchBody =>
      '**Notifier** hält einen Cache: **search()** überschreibt ihn, wie User List **fetchUsers**. **Family** steckt die Query in den Schlüssel — **userSearchFamilyProvider(\'Grace\')** und **(\'10\')** sind zwei Caches. Family-State ist **AsyncValue**, nicht UserSearchState.';

  @override
  String userValue(String name) {
    return 'Benutzer: $name';
  }

  @override
  String get id => 'Id';

  @override
  String get age => 'Alter';

  @override
  String get email => 'E-Mail';

  @override
  String get fieldRequired => 'Pflichtfeld.';

  @override
  String get invalidNumber => 'Bitte eine Zahl eingeben.';

  @override
  String get invalidEmail => 'Bitte eine gültige E-Mail eingeben.';

  @override
  String get duplicateUserId => 'Ein Benutzer mit dieser Id existiert bereits.';

  @override
  String get duplicateEmail =>
      'Ein Benutzer mit dieser E-Mail existiert bereits.';

  @override
  String get userAdded => 'Benutzer hinzugefügt.';

  @override
  String get errorTitle => 'Fehler';

  @override
  String get listenManual => 'Listen Manual';

  @override
  String get listenManualBody =>
      'Derselbe gespeicherte Fehler, vier Farben. Lila watch ist immer der Live-Wert — nach Zurück gefüllt. Grau read ist beim Öffnen eingefroren. Rot listenManual ist der Dialog (auch beim Wiederöffnen). Türkisgrün listen ist die SnackBar und bleibt beim zweiten Besuch leer.';

  @override
  String get listenManualWatchLabel => 'watch';

  @override
  String get listenManualIdle => 'Live-Wert. Jetzt leer.';

  @override
  String get listenManualStored => 'Live-Wert. Gefüllt — bleibt nach Zurück.';

  @override
  String get listenManualStoreError => 'Fehler speichern';

  @override
  String get listenManualClearError => 'Fehler löschen';

  @override
  String get listenManualFetchFailed =>
      'Konnte nicht geladen werden. Bleibt, bis du Fehler löschen tippst.';

  @override
  String get listenManualManualLabel => 'listenManual';

  @override
  String get listenManualManualIdle => 'Beim Öffnen kein gespeicherter Fehler.';

  @override
  String get listenManualManualFired =>
      'Beim Öffnen gelaufen — Fehler war schon da.';

  @override
  String get listenManualListenLabel => 'listen';

  @override
  String get listenManualListenIdle => 'Keine Änderung in diesem Besuch.';

  @override
  String get listenManualListenFired =>
      'Hat eine Änderung in diesem Besuch gesehen.';

  @override
  String get listenManualListenSnackBar =>
      'listen: der Wert hat sich geändert.';

  @override
  String get listenManualReadLabel => 'read';

  @override
  String get listenManualReadIdle =>
      'Snapshot beim Öffnen: null. Fehler speichern ändert das nicht.';

  @override
  String get listenManualReadFired =>
      'Snapshot beim Öffnen: gespeicherter Fehler. initState ist neu gelaufen.';

  @override
  String get consumerWidget => 'Consumer Widget';

  @override
  String get consumerWidgetBody =>
      'Beide Panels zeigen dieselben Benutzer, weil sie denselben Provider **watch**en.\n\nOben: ein **StatelessWidget** umhüllt **Consumer** nur, um an **ref** zu kommen.\n\nUnten: **ConsumerWidget** — **build** hat **ref** schon als Parameter, ohne Wrapper. Nimm **ConsumerWidget**.\n\n**ConsumerStatefulWidget** nur, wenn du **initState** oder **dispose** brauchst.';

  @override
  String get consumerWrapLabel => 'StatelessWidget + Consumer';

  @override
  String get consumerWidgetLabel => 'ConsumerWidget';

  @override
  String get addDemoUser => 'Demo-Benutzer hinzufügen';

  @override
  String get quote => 'Quote';

  @override
  String get quoteBody =>
      'Der Screen **watch**t beide **FutureProvider** — eine Karte je Provider. Beide bauen über **AsyncValue** neu: loading, data, error. Jeder GET nimmt eine zufällige Quote.\n\n**FutureProvider** hat kein Extra-Input. **Get new quote** **invalidate**t den Cache, damit der GET erneut läuft. **Fail call** setzt ein Flag in der Data Source und **invalidate**t diesen Provider. Ein Feld an einem Objekt ist kein Provider-State.\n\n**FutureProvider + input** — nicht der Screen — **watch**t die Quote-Nummer. **Increment number** zählt um eins hoch. Riverpod startet diesen GET ohne **invalidate**. Die andere Karte bleibt. Das ist das Future-Gegenstück zu **search()**, das **state** setzt.\n\nDer fehlgeschlagene GET wirft **NetworkException**. Das Repository mappt auf **NetworkFailure**.\n\n`retry` ist null, damit Riverpod 3 den Fehler nicht von allein noch einmal startet (~200ms). Ohne das bleibt **Fail call** nicht auf dem Screen.\n\nEine **SnackBar** ist ein Debug-Print der Riverpod-Calls, nicht des Buttons. **Get new quote** → **invalidate() → watch()**. **Fail call** → **read() + invalidate() → watch()** (Notifier). **Increment number** → **read() → watch()** — das Future **watch**t die Nummer, kein **invalidate**.';

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
      'Der Screen **watch**t einen handgeschriebenen **StreamProvider**, solange **Start** an ist. **AsyncValue** ist loading, dann bei jedem Tick neues **data**, oder **error**.\n\nEin **FutureProvider** (Quote) läuft einmal. Ein **StreamProvider** bleibt am Stream. **watch** baut bei jedem Event neu.\n\n**Stop** beendet das **watch**. `autoDispose` bricht den Fake-**/tick**-Stream und den Timer ab. **Start** **watch**t wieder — ein neuer Stream bei Tick 1.\n\n**Invalidate** ist ein neues Listen auf demselben Provider, wieder bei Tick 1, ohne Stop. Wie ein neuer GET bei Quote.\n\n**Fail call** setzt ein Flag in der Data Source. Der nächste Tick wirft **NetworkException**. Das Repository mappt auf **NetworkFailure**. **AsyncValue** ist **error**. **watch** bleibt. Kein **invalidate** auf diesem Tap — der Fehler ist das nächste Event. **Start** danach startet einen neuen Stream (**invalidate**, **watch** bleibt).\n\n`retry` ist null, damit Riverpod 3 den Fehler nicht von allein noch einmal startet (~200ms). Ohne das bleibt **Fail call** nicht auf dem Screen.\n\nEine **SnackBar** ist ein Debug-Print der Riverpod-Calls, nicht des Buttons. **Start** nach Stop → **read() → watch()**. **Start** nach **Fail call** → **invalidate() → watch()** (neuer Stream). **Stop** → **read() → unwatch**. **Invalidate** → **invalidate() → watch()**. **Fail call** → **read()**.';

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
      '**refresh** ist immer **invalidate** plus ein sofortiges **read**. Deshalb gibt refresh ein Future zurück. Nutze **refresh**, wenn dieser Callback warten muss. **Pull-to-refresh** ist der übliche Fall.\n\nNutze **invalidate**, wenn du nicht warten musst. Es markiert den Provider als veraltet. Wer **watch**t, lädt nach. Das ist die übliche Wahl nach einer Mutation: Speichern, Löschen, Logout, oder wenn der Cache alt ist.\n\n**Refresh** und **Refresh 3x** sperren, solange sie warten, damit du nicht stapeln kannst. **Invalidate** bleibt tippbar.\n\n**Invalidate 3x** startet einen GET. **Refresh 3x** startet drei. Der **Refresh**-Button blinkt einmal. **Refresh 3x** blinkt dreimal.';

  @override
  String get refreshLabWatchLabel => 'watch';

  @override
  String get refreshLabLoading => 'Laden…';

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
